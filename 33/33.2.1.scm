#lang racket

(define (is-inf? x)
  (or
    (= x +inf.f)
    (= x -inf.f)
    (= x +inf.0)
    (= x -inf.0)))

(define (find-overflow)
  (local ((define (f n)
            (cond [(is-inf? (expt #i10.0 n)) (sub1 n)]
                  [else (f (add1 n))])))
         (f 0)))

(require rackunit)
(require rackunit/text-ui)

(define find-overflow-tests
  (test-suite
   "Test for find-overflow"

   (check-equal? (find-overflow) 308)
   ))

(exit (run-tests find-overflow-tests))
