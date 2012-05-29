#lang racket

(define (ff-make-posn x y)
  (lambda (select)
    (select x y)))

(define (ff-posn-x a-ff-posn) (a-ff-posn (lambda (x y) x)))
(define (ff-posn-y a-ff-posn) (a-ff-posn (lambda (x y) y)))


(require rackunit)
(require rackunit/text-ui)

(define ff-make-posn-tests
  (test-suite
   "Test for ff-make-posn"

   (check-equal? (ff-posn-x (ff-make-posn 3 4)) 3)
   (check-equal? (ff-posn-y (ff-make-posn 3 4)) 4)
   ))

(exit (run-tests ff-make-posn-tests))

; Strange way to implement structure.
