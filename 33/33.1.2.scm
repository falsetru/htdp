#lang racket
(require "33.1.1.scm")

;(define (log10 n) (/ (log n) (log 10)))
(define (log10 n) (sub1 (string-length (number->string n))))

(define (inex-* a b)
  (local ((define e-a (* (inex-sign a) (inex-exponent a)))
          (define e-b (* (inex-sign b) (inex-exponent b)))
          (define e-new (+ e-a e-b))
          (define i (make-inex
                      (* (inex-mantissa a) (inex-mantissa b))
                      (if (< e-new 0) -1 +1)
                      (abs e-new)))
          (define i-m (inex-mantissa i))
          (define i-m-e (log10 i-m))
          )
         (cond [(> i-m 99) (inex-adjust i (- i-m-e 1))]
               [else i])
         ))


(require rackunit)
(require rackunit/text-ui)

(define inex*-tests
  (test-suite
   "Test for inex*"

   (check-equal? (inex-* (create-inex 5 1 0) (create-inex 2 1 0))
                 (create-inex 10 1 0))
   (check-equal? (inex-* (create-inex 2 1 4) (create-inex 8 1 10))
                 (create-inex 16 1 14))
   (check-equal? (inex-* (create-inex 20 -1 1) (create-inex 5 1 4))
                 (create-inex 10 1 4))
   (check-equal? (inex-* (create-inex 27 -1 1) (create-inex 7 1 4))
                 (create-inex 19 1 4))
   (check-equal? (inex-* (create-inex 27 -1 9) (create-inex 7 1 4))
                 (create-inex 19 -1 4))
   ))

(exit (run-tests inex*-tests))
