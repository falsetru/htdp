#lang racket

(define (my-expt n e)
  (cond [(zero? n) 1]
        [(= e 1) n]
        [else (* (my-expt n (sub1 e)) n)]))

(define inex (+ 1 #i1e-12))
(define exac (+ 1 1e-12))


(require rackunit)
(require rackunit/text-ui)

(define my-expt-tests
  (test-suite
   "Test for my-expt"

   (check-equal? (my-expt inex 30) #i1.0000000000300027)
   (check-equal? (my-expt exac 30) 1.0000000000300027)
   ))

(exit (run-tests my-expt-tests))
