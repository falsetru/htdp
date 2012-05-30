#lang racket

(define-struct girlfriend (name hair eyes number-past-dates) #:mutable)
(define (one-more-date f)
  (set-girlfriend-number-past-dates! f (add1 (girlfriend-number-past-dates f))))

(require rackunit)
(require rackunit/text-ui)

(define grilfriend-modify-tests
  (test-suite
   "Test for grilfriend-modify"

   (test-case
    "girlfriend"
    (define f (make-girlfriend 'Jane 'black 'green 99))
    (one-more-date f)
    (check-equal? (girlfriend-number-past-dates f) 100)
    )
   ))

(exit (run-tests grilfriend-modify-tests))
