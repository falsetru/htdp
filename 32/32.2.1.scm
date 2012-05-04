(define-struct state (left board-on-left right)); left, right: side / board-on-left: bool
(define-struct side (m c))  ; m, c: number

(define initial (make-state (make-side 3 3) true (make-side 0 0)))
(define final (make-state (make-side 0 0) false (make-side 3 3)))
