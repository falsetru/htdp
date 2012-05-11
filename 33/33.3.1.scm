#lang racket

(define (find-underflow)
  (local ((define (f n)
            (cond [(= (expt #i10.0 n) #i0) (add1 n)]
                  [else (f (sub1 n))])))
         (f 0)))

(require rackunit)
(require rackunit/text-ui)

(define find-underflow-tests
  (test-suite
   "Test for find-underflow"

   (check-equal? (find-underflow) -323)
   ))

(exit (run-tests find-underflow-tests))
