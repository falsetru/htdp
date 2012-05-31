#lang racket

(define-struct CD (price title artist) #:transparent #:mutable)
(define-struct record (price antique title artist) #:transparent #:mutable)
(define-struct DVD (price title artist to-appear) #:transparent #:mutable)
(define-struct tape (price title artist) #:transparent #:mutable)

; music-item: one of CD,record,DVD,tape
(define (inflate! item rate)
  (cond [(CD?     item) (CD-inflate!     item rate)]
        [(record? item) (record-inflate! item rate)]
        [(DVD?    item) (DVD-inflate!    item rate)]
        [(tape?   item) (tape-inflate!   item rate)]))

(define (CD-inflate! item rate)
  (set-CD-price! item (* (CD-price item) (+ 1 rate))))
(define (record-inflate! item rate)
  (set-record-price! item (* (record-price item) (+ 1 rate))))
(define (DVD-inflate! item rate)
  (set-DVD-price! item (* (DVD-price item) (+ 1 rate))))
(define (tape-inflate! item rate)
  (set-tape-price! item (* (tape-price item) (+ 1 rate))))

(require rackunit)
(require rackunit/text-ui)

(define inflate!-tests
  (test-suite
   "Test for inflate!"

   (test-case
    ""
    (define a-cd (make-CD 1000 'ABC 'anonymous))
    (inflate! a-cd 1/2)
    (check-equal? a-cd (make-CD 1500 'ABC 'anonymous))
    )
   ))

(exit (run-tests inflate!-tests))
