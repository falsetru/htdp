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
        ;[(call? x) (make-call (call-name call) (subst v n (call-arg x)))]
        [else (error "not a valid expression")]))


(define (evaluate-with-one-def expr func)
  (cond [(symbol? expr) (error "evaluate-with-one-def: symbol unresolved" expr)]
        [(number? expr) expr]
        [(add? expr) (+ (evaluate-with-one-def (add-left  expr) func)
                        (evaluate-with-one-def (add-right expr) func))]
        [(mul? expr) (* (evaluate-with-one-def (mul-left  expr) func)
                        (evaluate-with-one-def (mul-right expr) func))]
        [(call? expr)
         (cond [(symbol=? (call-name expr) (function-name func))
                (evaluate-with-one-def
                  (subst (function-param func)
                         (evaluate-with-one-def (call-arg expr) func)
                         (function-body func))
                  func)]
               [else (error "evaluate-with-one-def: unknown function:" (call-name expr))])]
        [else (error "evaluate-with-one-def: unknown expression: " expr)]))



;   (evaluate-with-one-def () )
(require rackunit)
(require rackunit/text-ui)

(define 17.7.3-tests
  (test-suite
   "Test for 17.7.3"

   (test-case
    "(+ (add5 5) (add5 15)) -> 20
     (+ (add5 (+ 9 1)) (add5 15)) -> 20
     "
    
    (define a-func-def (make-function 'add5 'x (make-add 'x 5)))
    (define a-expr (make-add (make-call 'add5 5) (make-call 'add5 15)))
    (define b-expr (make-add (make-call 'add5 (make-add 9 1)) (make-call 'add5 15)))
    (check-equal? (evaluate-with-one-def a-expr a-func-def) 30)
    (check-equal? (evaluate-with-one-def b-expr a-func-def) 35)
    )
   ))

(run-tests 17.7.3-tests)
