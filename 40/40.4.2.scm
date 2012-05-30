#lang racket

(define (clear v)
  (begin
    (vector-set! v 0 0)
    (vector-set! v 1 0)
    (vector-set! v 2 0)))

(require rackunit)
(require rackunit/text-ui)

(define clear-tests
  (test-suite
   "Test for clear"

   (test-case
    ""
    (define v (vector 1 2 3))
    (clear v)
    (check-equal? v '#(0 0 0))
    )
   ))

(exit (run-tests clear-tests))
