#lang racket

(define-struct cheerleader (name dates) #:mutable)
(define (new-date cl date)
  (set-cheerleader-dates! cl (cons date (cheerleader-dates cl))))

(require rackunit)
(require rackunit/text-ui)

(define new-date-tests
  (test-suite
   "Test for new-date"

   (test-case
    "prepend 'Frank"
    (define cl (make-cheerleader 'JoAnn '(Carl Bob Dude Adam Emil)))
    (new-date cl 'Frank)
    (check-equal? (cheerleader-dates cl) '(Frank Carl Bob Dude Adam Emil))
    )
   ))

(exit (run-tests new-date-tests))
