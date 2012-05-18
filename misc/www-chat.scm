#lang racket
;; http://groups.google.com/group/racket-users/browse_thread/thread/1d03315002fc3b6a?fwc=2


(require web-server/servlet-env
         web-server/http/bindings
         web-server/http/response-structs
         racket/file)

(define channels empty)

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


(define-values (parent-dir filename be-dir?)
               (split-path (find-system-path 'run-file)))
(define html-file-path (build-path parent-dir "www-chat.html"))
(define (default-page)
  (format (file->string html-file-path)
   *alarm-timeout*))

;; handle-default: request -> response
(define (handle-default req)
  (response/full 200 #"Okay"
                 (current-seconds)
                 TEXT/HTML-MIME-TYPE
                 empty
                 (list #"" (string->bytes/utf-8 (default-page)))))

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
               #:port 8080)
