#lang racket

(require rackunit)
(require rackunit/text-ui)

(define increase-x-tests
  (test-suite
   "Test for increase-x"

   (test-case
    "increase-x"
    (define x 3)
    (define (increase-x)
      (begin
        (set! x (+ x 1))
        x))

    (check-equal? (increase-x) 4)
    (check-equal? x 4)
    (check-equal? (increase-x) 5)
    (check-equal? x 5)
    (check-equal? (increase-x) 6)
    (check-equal? x 6)
    )
   ))

(exit (run-tests increase-x-tests))
