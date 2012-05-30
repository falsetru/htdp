#lang racket

(define (board-flip! board i j)
  (vector-set! (vector-ref board i) j
               (not (vector-ref (vector-ref board i) j))))


(require rackunit)
(require rackunit/text-ui)

(define board-flip!-tests
  (test-suite
   "Test for board-flip!"

   (test-case
    ""
    (define a-board (vector (vector true  false false)
                            (vector false true  false)
                            (vector false false true )))

    (board-flip! a-board 1 1)
    (check-equal? a-board (vector (vector true  false false)
                                  (vector false false false)
                                  (vector false false true )))
    (board-flip! a-board 2 0)
    (check-equal? a-board (vector (vector true  false false)
                                  (vector false false false)
                                  (vector true  false true )))
    )
   ))

(exit (run-tests board-flip!-tests))
