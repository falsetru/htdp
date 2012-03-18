(define-struct add (left right))
(define-struct mul (left right))

; 1. (+ 10 -10)
(make-add 10 -10)

; 2. (+ (* 20 3) 33)
(make-add (make-mul 20 3) 33)

; 3. (* 3.14 (* r r))
(make-mul 3.14 (make-mul r r))

; 4. (+ (* 9/5 c) 32)
(make-add (make-mul 9/5 c) 32)

; 5. (+ (* 3.14 (* o o)) (* 3.14 (* i i)))
(make-add (make-mul 3.14 (make-mul o o)) (make-mul 3.14 (make-mul i i)))
