#lang racket

(define (serve-udp-echo
          #:port [port 7])
  (local ((define s (udp-open-socket))
          (define data (make-bytes 1024))
          (define (loop)
            (local
              ((define-values (nrecv remote-host remote-port) (udp-receive! s data)))
              (printf "Received: ~a , send back!\n"
                      (bytes->string/utf-8 data false 0 nrecv))
              (udp-send-to s remote-host remote-port data 0 nrecv)
              (loop))))
         (udp-bind! s false port)
          (loop)))

(serve-udp-echo #:port 7777)
