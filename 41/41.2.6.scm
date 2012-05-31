#lang racket

(require "41.2.5.scm")

(define (move-shape! a-shape delta)
  (cond
    [(circle? a-shape) (move-circle! a-shape delta)]
    [(square? a-shape) (move-square! a-shape delta)]))


(require rackunit)
(require rackunit/text-ui)

(define move-shape!-tests
  (test-suite
   "Test for move-shape!"

   (test-case "move-square!"
    (define a-sq (make-square (make-posn 5 6) 10))
    (move-shape! a-sq 5)
    (check-equal? a-sq (make-square (make-posn 10 6) 10)))

   (test-case "move-circle!"
    (define a-cc (make-circle (make-posn 10 10) 5))
    (move-shape! a-cc 9)
    (check-equal? a-cc (make-circle (make-posn 19 10) 5)))
   ))


(exit (run-tests move-shape!-tests))
