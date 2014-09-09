#lang racket

(define definitions empty)

;; Doesn't fulfill the specification:
;; "If a user adds two (or more) definitions for some function f,
;; the last addition is the one that matters. The previous ones can be ignored. "
;(define (add-definition definition)
 ; (set! definitions (cons definition definitions)))

;; Requires dropping the function definition if already
;; present, which can be accomplished with the help of
;; remove.

; 동일한 함수 정의를 두번 추가할 경우
; 나중에 추가된 정의가 리스트의 앞쪽에 위치한다.
; --> 마지막에 추가된 정의가 사용된다!

(define (evaluate expr)
  (evaluate-with-defs expr definitions))




(define-struct add (left right))
(define-struct mul (left right))
(define-struct call (name arg))

(define-struct function (name param body))
    ; name: symbol
    ; param: symbol
    ; body: expression (one of add, mul, call, symbol, number)

(define (subst v n x)
  (cond [(number? x) x]
        [(symbol? x)
         (cond [(symbol=? x v) n]
               [else x])]
        [(add? x) (make-add (subst v n (add-left x)) (subst v n (add-right x)))]
        [(mul? x) (make-mul (subst v n (mul-left x)) (subst v n (mul-right x)))]
        [(call? x) (make-call (call-name x) (subst v n (call-arg x)))]
        [else (error "not a valid expression")]))

(define (evaluate-call expr defs)
  (cond [(empty? defs) (error "Unresolved function: " (call-name expr))]
        [(symbol=? (call-name expr) (function-name (first defs)))
         (evaluate-with-defs
           (subst (function-param (first defs))
                  (evaluate-with-defs (call-arg expr) definitions)
                  (function-body (first defs)))
           definitions)]
        [else (evaluate-call expr (rest defs))]))

(define (evaluate-with-defs expr defs)
  (cond [(symbol? expr) (error "evaluate-with-one-def: symbol unresolved" expr)]
        [(number? expr) expr]
        [(add? expr) (+ (evaluate-with-defs (add-left  expr) defs)
                        (evaluate-with-defs (add-right expr) defs))]
        [(mul? expr) (* (evaluate-with-defs (mul-left  expr) defs)
                        (evaluate-with-defs (mul-right expr) defs))]
        [(call? expr) (evaluate-call expr defs)]
        [else (error "evaluate-with-one-def: unknown expression: " expr)]))



(require rackunit)
(require rackunit/text-ui)

(define definition-evaluate-tests
  (test-suite
   "Test for definition-evaluate"

   (test-case
    "(+ (add5 5) (mul2 15)) -> 40"

    (set! definitions empty)
    (define a-func-def (make-function 'add5 'x (make-add 'x 5)))
    (define b-func-def (make-function 'mul2 'x (make-mul 'x 2)))
    (add-definition a-func-def)
    (add-definition b-func-def)
    (define a-expr (make-add (make-call 'add5 5) (make-call 'mul2 15)))
    (check-equal? (evaluate a-expr) 40)
    )

   (test-case
    "f1 call f2. f2 call f3. f3 ...."
    (set! definitions empty)
    (define f1 (make-function 'f1 'x (make-call 'f2 'x)))
    (define f2 (make-function 'f2 'x (make-call 'f3 'x)))
    (define f3 (make-function 'f3 'x (make-call 'f4 'x)))
    (define f4 (make-function 'f4 'x (make-call 'f5 'x)))
    (define f5 (make-function 'f5 'x 'x))
    (add-definition f1)
    (add-definition f2)
    (add-definition f3)
    (add-definition f4)
    (add-definition f5)
    (define a-expr (make-call 'f1 9))

    (check-equal? (evaluate a-expr) 9)
    )
   ))

(exit (run-tests definition-evaluate-tests))
