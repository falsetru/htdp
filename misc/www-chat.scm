#lang racket
;; http://groups.google.com/group/racket-users/browse_thread/thread/1d03315002fc3b6a?fwc=2


(require web-server/servlet-env
         web-server/http/bindings
         web-server/http/response-structs)

(define channels empty)

(void
 (thread (lambda ()
           (define (start req)
             (cond [(exists-binding? 'comet (request-bindings req))
                    (handle-comet req)]
                   [(exists-binding? 'msg (request-bindings req))
                    (handle-msg req)]
                   [else
                    (handle-default req)]))
           (serve/servlet start
                          #:servlet-path "/comet"
                          #:banner? #f
                          #:launch-browser? #t
                          #:port 8080))))


;; How long will we wait until we ask the client to try again?
;; 30 second timeout for the moment.
(define *alarm-timeout* 30000)

;; handle-comet: request -> response
(define (handle-comet req)
  (let* ([ch (make-channel)]
         [an-alarm (alarm-evt (+ (current-inexact-milliseconds)
                                 *alarm-timeout*))]
         [not_used (set! channels (cons ch channels))]
         [v (sync ch an-alarm)])
    (cond
      [(eq? v an-alarm)
       ;; Cause the client to see that they need to try reconnecting
       (response/full 200 #"Try again"
                      (current-seconds)
                      #"text/plain; charset=utf-8"
                      empty
                      (list #"" #""))]
      [else
       (response/full 200 #"Okay"
                      (current-seconds)
                      #"text/plain; charset=utf-8"
                      empty
                      (list #"" (string->bytes/utf-8 (format "~s" v))))])))

(define default-page
  (format
   #<<EOF
<html>
<head>
<script>

var XMLHttpFactories = [
    function () {return new XMLHttpRequest()},
    function () {return new ActiveXObject("Msxml2.XMLHTTP")},
    function () {return new ActiveXObject("Msxml3.XMLHTTP")},
    function () {return new ActiveXObject("Microsoft.XMLHTTP")}
];
var createXMLHTTPObject = function() {
    var xmlhttp = false;
    for (var i=0;i<XMLHttpFactories.length;i++) {
            try {
                    xmlhttp = XMLHttpFactories[i]();
            }
            catch (e) {
                    continue;
            }
            break;
    }
    return xmlhttp;
}

var post = function(msg) {
    var req = createXMLHTTPObject();
    if (!req) return;
    req.open("POST", "/comet", true);
    req.setRequestHeader('Content-type','application/x-www-form-urlencoded');
    req.send("msg=" + encodeURIComponent(msg));
}

var sendmsg = function() {
    var name = document.getElementById('name');
    var msg = document.getElementById('msg');
    var n = name.value.replace(/^\s+|\s+$/g, '');
    var m = msg.value.replace(/^\s+|\s+$/g, '');
    if (! m)
       return;

    post(n + ': ' + m);
    msg.value = '';
    msg.focus();
}

var sendmsg2 = function(event) {
    if (event.keyCode == 13)
        sendmsg();
}

var startComet = function() {
    // http://www.quirksmode.org/js/xmlhttp.html//
    // XMLHttpRequest wrapper.  Transparently restarts the request
    // if a timeout occurs.
    var sendRequest = function(url,callback,postData) {
        var req = createXMLHTTPObject(), method, TIMEOUT = ~s;
        if (!req) return;
        method = (postData) ? "POST" : "GET";
        req.open(method,url,true);
        if (postData) {
            req.setRequestHeader('Content-type','application/x-www-form-urlencoded');
        }
        req.onreadystatechange = function () {
                if (req.readyState !== 4) return;
                if (req.status === 200 && req.statusText === 'Try again') {
                    req.abort();
                    setTimeout(function() { sendRequest(url, callback, postData); }, 0);
                    return;
                }
                if (req.status !== 200 && req.status !== 304) {
                    return;
                }
                callback(req);
        }
        if (req.readyState === 4) return;
        req.send(postData);
    }

    sendRequest(
        "/comet",
        function(req) {
            document.body.appendChild(document.createTextNode(req.responseText));
            document.body.appendChild(document.createElement("br"));
            setTimeout(startComet, 0);
        },
        "comet=t"
    );
};

var whenLoaded = function() {
    document.getElementById("name").focus();
    setTimeout(startComet, 0);
};

</script>
</head>
<body onLoad="whenLoaded()">
    <div>
        <input type="text" id="name" value="nobody" size="5" />
        <input type="text" id="msg" onkeypress="sendmsg2(event)" />
        <button id="btn" onclick="sendmsg()">Send</button>
    </div>
</body>
</html>
EOF
   *alarm-timeout*))

;; handle-default: request -> response
(define (handle-default req)
  (response/full 200 #"Okay"
                 (current-seconds)
                 TEXT/HTML-MIME-TYPE
                 empty
                 (list #"" (string->bytes/utf-8 default-page))))

;; handle-msg: request -> response
(define (handle-msg req)
  (broadcast
    (extract-binding/single 'msg (request-bindings req)))
  (response/full 200 #"Okay"
                 (current-seconds)
                 TEXT/HTML-MIME-TYPE
                 empty
                 (list #"" #"sent")))


;; broadcast: any -> void
;; Sends a message to the client.
(define (broadcast v)
  (for-each
   (lambda (ch)
     (channel-put ch v))
   channels)
  (set! channels empty))
