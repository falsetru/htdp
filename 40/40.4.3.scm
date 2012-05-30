#lang racket

(define (swap v)
  (local ((define tmp (vector-ref v 0)))
         (begin
           (vector-set! v 0 (vector-ref v 1))
           (vector-set! v 1 tmp))))

(require rackunit)
(require rackunit/text-ui)

(define swap-tests
  (test-suite
   "Test for swap"

   (test-case
    ""
    (define v (vector 3 4))
    (swap v)
    (check-equal? v '#(4 3))
    )
   ))

(exit (run-tests swap-tests))
