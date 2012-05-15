#lang racket

(define s (udp-open-socket))



(define (loop)
  (local 
    ((define data
       (string->bytes/utf-8
         (list->string (take (drop (string->list (number->string (random))) 2) 7))))
     (define data2 (make-bytes 1024)))
    (udp-send-to s "localhost" 7777 data)
    (define-values (nrecv remote-host remote-port) (udp-receive! s data2))
    (printf "Received: ~a\n" (bytes->string/utf-8 data false 0 nrecv))
    (sleep 1)
    (loop)))

(loop)
