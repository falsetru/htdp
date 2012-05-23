#lang racket

; (define (f x) 
;  (begin
;    (set! y x)
;    x))
;
; 에러: y 정의 안됨


(define (f x) 
  (begin
    (set! f x)
    x))

;(local ((define-struct hide (it))
;        (define make-hide 10))
;       (hide? 10))
;
; 에러: define-struct로 만들어진 make-hide 와
;       직접 정의한 make-hide 두개의 정의가 존재


;(local ((define-struct loc (con))
;        (define loc 10))
;       (loc? 10))
;
; 에러: loc 정의 두개


;(define f
;  (lambda (x y x)
;    (* x y z)))
;
;(define z 3.14)
;
; 에러: 파라미터 x 중복
