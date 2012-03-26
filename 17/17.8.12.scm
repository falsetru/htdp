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
                  (evaluate-with-defs (call-arg expr) defs)
                  (function-body (first defs)))
           defs)]
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

(define (test-evaluate expr defs expected)
  (equal? (evaluate-with-defs expr defs) expected))


(require rackunit)
(require rackunit/text-ui)

(define test-evaluate-tests
  (test-suite
   "Test for test-evaluate"

   (test-case
    "(+ (add5 5) (mul2 15)) -> 40"

    (define a-func-def (make-function 'add5 'x (make-add 'x 5)))
    (define b-func-def (make-function 'mul2 'x (make-mul 'x 2)))
    (define a-expr (make-add (make-call 'add5 5) (make-call 'mul2 15)))
    (check-equal? (test-evaluate a-expr (list a-func-def b-func-def) 40) true)
    )

   (test-case
    "f1 call f2. f2 call f3. f3 ...."
    (define f1 (make-function 'f1 'x (make-call 'f2 'x)))
    (define f2 (make-function 'f2 'x (make-call 'f3 'x)))
    (define f3 (make-function 'f3 'x (make-call 'f4 'x)))
    (define f4 (make-function 'f4 'x (make-call 'f5 'x)))
    (define f5 (make-function 'f5 'x 'x))
    (define a-expr (make-call 'f1 9))

    (check-equal? (test-evaluate a-expr (list f1 f2 f3 f4 f5) 9) true)
    (check-equal? (test-evaluate a-expr (list f1 f2 f3 f4 f5) 8) false)
    )
   ))

(run-tests test-evaluate-tests)
