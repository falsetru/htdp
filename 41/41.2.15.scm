#lang racket

(define (reset-interval v from to)
  (cond [(> from to) (void)]
        [else
          (begin (vector-set! v to false)
                 (reset-interval v from (sub1 to)))]))

(require rackunit)
(require rackunit/text-ui)

(define reset-interval-tests
  (test-suite
   "Test for reset-interval"

   (test-case
    ""
    (define v (vector #t #t #t #t #t #t #t))
    (reset-interval v 1 3)
    (check-equal? v (vector #t #f #f #f #t #t #t))
    (set! v (vector #t #t #t #t #t #t #t))
    (reset-interval v 0 (sub1 (vector-length v)))
    (check-equal? v (vector #f #f #f #f #f #f #f))
    )
   ))

(exit (run-tests reset-interval-tests))
