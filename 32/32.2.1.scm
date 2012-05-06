(define-struct state (left boat-on-left right) #:transparent); left, right: side / board-on-left: bool
(define-struct side (m c) #:transparent)  ; m, c: number

(define initial (make-state (make-side 3 3) true (make-side 0 0)))
(define final (make-state (make-side 0 0) false (make-side 3 3)))
