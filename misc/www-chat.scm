#lang racket
;; http://groups.google.com/group/racket-users/browse_thread/thread/1d03315002fc3b6a?fwc=2


(require web-server/servlet-env
         web-server/http/bindings
         web-server/http/response-structs
         racket/file
         racket/runtime-path)

(define channels empty)
;; broadcast: any -> void
;; Sends a message to the client.
(define (broadcast v)
  (for-each
   (lambda (ch)
     (channel-put ch v))
   channels)
  (set! channels empty))

;; How long will we wait until we ask the client to try again?
;; 30 second timeout for the moment.
(define *alarm-timeout* 30000)

;; handle-comet: request -> response
(define (handle-comet req)
  (let* ([ch (make-channel)]
         [not_used (set! channels (cons ch channels))]
         [an-alarm (alarm-evt (+ (current-inexact-milliseconds)
                                 *alarm-timeout*))]
         [v (sync ch an-alarm)])
    (cond
      [(eq? v an-alarm)
       ;; Cause the client to see that they need to try reconnecting
       (response/full 200 #"Try again"
                      (current-seconds)
                      #"text/plain; charset=utf-8"
                      empty
                      (list #""))]
      [else
       (response/full 200 #"Okay"
                      (current-seconds)
                      #"text/plain; charset=utf-8"
                      empty
                      (list (string->bytes/utf-8 v)))])))


(define-runtime-path html-file-path "www-chat.html")
(define (default-page) (file->string html-file-path))

;; handle-default: request -> response
(define (handle-default req)
  (response/full 200 #"Okay"
                 (current-seconds)
                 TEXT/HTML-MIME-TYPE
                 empty
                 (list (string->bytes/utf-8 (default-page)))))

;; handle-msg: request -> response
(define (handle-msg req)
  (broadcast
   (extract-binding/single 'msg (request-bindings req)))
  (response/full 200 #"Okay"
                 (current-seconds)
                 TEXT/HTML-MIME-TYPE
                 empty
                 (list #"sent")))


(define (start req)
  (cond [(exists-binding? 'comet (request-bindings req))
         (handle-comet req)]
        [(exists-binding? 'msg (request-bindings req))
         (handle-msg req)]
        [else
         (handle-default req)]))
(serve/servlet start
               #:servlet-path "/chat"
               #:banner? #f
               #:launch-browser? #t
               #:port 8080)
