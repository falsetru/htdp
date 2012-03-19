(define-struct add (left right))
(define-struct mul (left right))
(define-struct function (name arg))

; (f (+ 1 1))
(make-function 'f (make-add 1 1))

; (* 3 (g 2))
(make-mul 3 (make-function 'g 2))
