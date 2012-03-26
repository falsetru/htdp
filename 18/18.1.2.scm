; 1.
(define x 1)
(local ((define x 10)
        (y (+ x x)))
       y)

; y LOCAL DEFINITION 구문에서 define이 없음
;   (define y (+ x x)))


; 2.
(local ((define (f x) (+ (* x x) (* 3 x) 15))
        (define x 100)
        (define f@100 (f x)))
       f@100 x)

; EXPRESSION이 두개.
; Student 이외 모드에서는 syntactically legal
; 
; EXPRESSION 을 다음 둘중 하나로 바꾸면 정상
; f@100
; 혹은
; x


;; 3.
(local ((define (f x) (+ (* x x) (* 3 x) 14))
        (define x 100)
        (define f (f x)))
       f)

; f가 두번 정의됨
