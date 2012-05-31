#lang racket

(require "41.2.5.scm")

(define (move-squares squares delta)
  (cond [(empty? squares) (void)]
        [else
          (begin
            (move-square! (first squares) delta)
            (move-squares (rest squares) delta))]))

(require rackunit)
(require rackunit/text-ui)

(define move-squares-tests
  (test-suite
   "Test for move-squares"

   (test-case
     ""
     (define sqs
       (list (make-square (make-posn 10 10) 10)
             (make-square (make-posn 12 30) 5)
             (make-square (make-posn 0 0) 3)))
     (move-squares sqs 10)
     (check-equal?
       sqs
       (list (make-square (make-posn 20 10) 10)
             (make-square (make-posn 22 30) 5)
             (make-square (make-posn 10 0) 3)))
     )
   ))

(exit (run-tests move-squares-tests))
