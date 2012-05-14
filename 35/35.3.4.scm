#lang racket

(require rackunit)
(require rackunit/text-ui)

(define change-to-3-tests
  (test-suite
   "Test for change-to-3"

   (test-case
    "change-to-3"
    (define x 0)
    (define y 1)
    (define (change-to-3 z)
      (begin
        (set! y 3)
        z))

    (check-equal? (change-to-3 x) 0)
    (check-equal? y 3)
    (check-equal? x 0)
    )
   ))

(exit (run-tests change-to-3-tests))
