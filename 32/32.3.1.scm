(define-struct board (n rows))
; n: number
; rows: (vectorof (vectorof hole))
; hole: bool (true: hole, false: peg)

(define-struct move (from to))
; from, to: position
; position: (listof 2 numbers)


(define example-board
  (make-board 4 '#('#(#f)
                   '#(#f #f)
                   '#(#f #f #t)
                   '#(#f #f #f #f))))

(define example-move
  (make-move '(0 0) '(2 2)))
