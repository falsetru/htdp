#lang racket
(provide
  example-board)

; board is (vectorof (vectorof hole))
; hole is bool (true: hole, false: peg)

; move is (listof 3 pos)
;          start-position, mid-point end-position
; pos is (listof 2 numbers)


(define example-board
  (vector (vector #f)
          (vector #f #f)
          (vector #f #f #t)
          (vector #f #f #f #f)))

(define example-move '((0 0) (1 1) (2 2)))
