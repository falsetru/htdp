#lang racket

(define-struct personnel (name address salary) #:mutable)
(define (increase-salary a-pr a-raise)
  (set-personnel-salary! a-pr (+ (personnel-salary a-pr) a-raise)))

(require rackunit)
(require rackunit/text-ui)

(define increase-salary-tests
  (test-suite
   "Test for increase-salary"

   (test-case "Bob's salary += 500'"
    (define a-pr (make-personnel 'Bob 'Pittsburgh 70000))
    (increase-salary a-pr 500)
    (check-equal? (personnel-salary a-pr) 70500)
    )
   ))

(exit (run-tests increase-salary-tests))
