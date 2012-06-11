#lang racket

; row,col is hole position
(define (create-peg-solitaire-board n row col)
  (build-vector n (lambda (i)
    (build-vector (add1 i) (lambda (j)
      (and (= i row) (= j col)))))))

(require rackunit)
(require rackunit/text-ui)

(define create-peg-solitaire-board-tests
  (test-suite
   "Test for create-peg-solitaire-board"

   (check-equal? (create-peg-solitaire-board 3 1 1)
                 '#(#(#f)
                    #(#f #t)
                    #(#f #f #f)))
   ))

(exit (run-tests create-peg-solitaire-board-tests))
