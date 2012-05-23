; 1.
(define x 3)
(define y 1)
(begin
  (set! y 4)
  (+ (* x x) (* y y)))
; ->
(define x 3)
(define y 4)
(begin
  (+ (* 3 3) (* 4 4)))
; ->
(+ 9 16)
; ->
25

; 2.
(define x 0)
(set! x
  (cond
    [(zero? 0) 1]
    [else 0]))
; ->
(define x 0)
(set! x
  (cond
    [true 1]
    [else 0]))
; ->
(define x 0)
(set! x 1)
; ->
(define x 1)


; 3.
(define (f x)
  (cond
    [(zero? x) 1]
    [else 0]))
(begin
  (set! f 11)
  11)
; ->
(define f 11)
(begin
  f)
; ->
11
