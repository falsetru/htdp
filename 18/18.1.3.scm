1.
(define A-CONSTANT
  (not 
   (local ((define (odd an)
             (cond
               [(= an 0) false]
               [else (even (- an 1))]))
           (define (even an)
             (cond
               [(= an 0) true]
               [else (odd (- an 1))])))
     (even a-nat-num))))

; 구문은 정상
; a-nat-num 이 정의되어있다면 정상


2.
(+ (local ((define (f x) (+ (* x x) (* 3 x) 15))
		(define x 100)
		(define f@100 (f x)))
	  f@100)
	1000)
; 정상


3.
(local ((define CONST 100)
        (define f x (+ x CONST)))
  (define (g x y z) (f (+ x (* y z)))))
; 구문에러 1: 두번째 LOCATION DEFINITION 에서 (f x)에 괄호 없음
; 구문에러 2: EXPRESSION 자리에 definition이 있음.
