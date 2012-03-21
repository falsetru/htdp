(define-struct add (left right))
(define-struct mul (left right))
(define-struct call (name arg))

; (f (+ 1 1))
(make-call 'f (make-add 1 1))

; (* 3 (g 2))
(make-mul 3 (make-call 'g 2))
