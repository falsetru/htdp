#lang racket

(require rackunit)
(require rackunit/text-ui)

(define switch-x-tests
  (test-suite
   "Test for switch-x"

   (test-case
    "switch-x"
    (define x 0)
    (define (switch-x)
      (begin
        (set! x (- x 1))
        x))
    (check-equal? (switch-x) -1)
    (check-equal? x -1)
    (check-equal? (switch-x) -2)
    (check-equal? x -2)
    (check-equal? (switch-x) -3)
    (check-equal? x -3)
    )
   ))

(exit (run-tests switch-x-tests))
