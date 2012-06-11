#lang racket

(require "43.3.1.scm")

(define (unplace-queen board i j)
  (board-for-all
    (lambda (I J x)
      (cond [(or (= i I)
                 (= j J)
                 (= (+ i j) (+ I J))
                 (= (- i j) (- I J))) true]
            [else x]))
    board))

(require rackunit)
(require rackunit/text-ui)

(define unplace-queen-tests
  (test-suite
   "Test for unplace-queen"

   (test-case
    ""
    (define board
      (build-vector
        3
        (lambda (i)
          (build-vector
            3
            (lambda (j) false)))))
    (unplace-queen board 0 0)
    (check-equal?
      board
      '#(#(#t #t #t)
         #(#t #t #f)
         #(#t #f #t)))
    )
   ))

(exit (run-tests unplace-queen-tests))
