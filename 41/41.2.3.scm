#lang racket

(define-struct personnel (name address salary) #:mutable)
(define (increase-percentage a-pr a-pct)
  (cond [(<= 3 a-pct 7)
         (set-personnel-salary!
           a-pr
           (+ (personnel-salary a-pr)
              (* (personnel-salary a-pr) a-pct 1/100)))]
        [else (error 'increase-salary "a-pct should be between 3% and 7%.")])
  
  )

(require rackunit)
(require rackunit/text-ui)

(define increase-percentage-tests
  (test-suite
   "Test for increase-percentage"

   (test-case "accept only values for a-raise between 3% and 7% of the salary."
    (define a-pr (make-personnel 'Bob 'Pittsburgh 70000))
    (check-exn exn? (lambda () (increase-percentage a-pr 10)))
    (increase-percentage a-pr 5) 
    (check-equal? (personnel-salary a-pr) 73500)
    )
   ))

(exit (run-tests increase-percentage-tests))
