; var is symbol
(define-struct Lam (var expr))
(define-struct LamApply (lam arg)) ; lam is Lam, arg is <exp>

; <exp> = var | Lam | LamApply

; 1. (lambda (x) y)
(make-Lam 'x 'y)

; 2.  ((lambda (x) x)
;      (lambda (x) x))
(make-LamApply (make-Lam 'x 'x) (make-Lam 'x 'x))

; 3.  (((lambda (y)
;               (lambda (x)
;                       y))
;        (lambda (z) z))
;      (lambda (w) w))

(make-LamApply
  (make-LamApply
    (make-Lam 'y (make-Lam 'x 'y))
    (make-Lam 'z 'z))
  (make-Lam 'w 'w))

; 변수 x가 자유롭게도 사용되고, 바인딩으로도 사용되는 표현)
(lambda (x) (lambda (y) x))
; ->
(make-Lam 'x (make-Lam 'y 'x))
