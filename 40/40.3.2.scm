#lang racket

(define-struct posn (x y) #:mutable)
(define (swap-posn p)
  (local ((define tmp (posn-x p)))
         (begin
           (set-posn-x! p (posn-y p))
           (set-posn-y! p tmp))))

(require rackunit)
(require rackunit/text-ui)

(define swap-posn-tests
  (test-suite
   "Test for swap-posn"

   (test-case
    "posn-swap"
    (define p (make-posn 3 4))
    (swap-posn p)
    (check-equal? (posn-x p) 4)
    (check-equal? (posn-y p) 3)
    )
   ))

(exit (run-tests swap-posn-tests))
