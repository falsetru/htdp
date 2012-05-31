#lang racket

(define-struct personnel (name address salary) #:mutable)
(define (increase-salary a-pr a-raise)
  (cond [(<= (* (personnel-salary a-pr) 3/100) a-raise (* (personnel-salary a-pr) 7/100))
         (set-personnel-salary! a-pr (+ (personnel-salary a-pr) a-raise))
         ]
        [else (error 'increase-salary "raise should be between 3% and 7%.")])
  )

(require rackunit)
(require rackunit/text-ui)

(define increase-salary-tests
  (test-suite
   "Test for increase-salary"

   (test-case "accept only values for a-raise between 3% and 7% of the salary."
    (define a-pr (make-personnel 'Bob 'Pittsburgh 70000))
    (check-exn exn? (lambda () (increase-salary a-pr 500)))
    (increase-salary a-pr 2400) 
    (check-equal? (personnel-salary a-pr) 72400)
    )
   ))

(exit (run-tests increase-salary-tests))
