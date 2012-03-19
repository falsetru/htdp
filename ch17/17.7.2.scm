(define-struct add (left right))
(define-struct mul (left right))
(define-struct call (name arg))

(define-struct function (name param body))
    ; name: symbol
    ; param: symbol
    ; body: expression (one of add, mul, call, symbol, number)


;(define (f x) (+ 3 x))
(make-function 'f 'x (make-add 3 'x))

;(define (g x) (* 3 x))
(make-function 'g 'x (make-mul 3 'x))

;(define (h u) (f (* 2 u)))
(make-function 'h 'u (make-call 'f (make-mul 2 'u)))

;(define (i v) (+ (* v v) (* v v)))
(make-function 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))

;(define (k w) (* (h w) (i w)))
(make-function 'k 'w (make-mul (make-call 'h 'w) (make-call 'i 'w)))
