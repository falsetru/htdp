(define-struct add (left right))
(define-struct mul (left right))

(define (evaluate-add x y) (+ (evaluate-expression x) (evaluate-expression y)))
(define (evaluate-mul x y) (* (evaluate-expression x) (evaluate-expression y)))

(define (evaluate-expression x)
  (cond [(number? x) x]
        [(add? x) (evaluate-add (add-left x) (add-right x))]
        [(mul? x) (evaluate-mul (mul-left x) (mul-right x))]
        [else (error "not a numeric expression")]))



(require rackunit)
(require rackunit/text-ui)

(define 14.4.3-tests
  (test-suite
   "Test for 14.4.3"

   (check-equal? (evaluate-expression 1) 1)
   (check-exn exn? (lambda () (evaluate-expression 'x)))
   (check-exn exn? (lambda () (evaluate-expression empty)))
   (check-exn exn? (lambda () (evaluate-expression false)))
   (check-exn exn? (lambda () (evaluate-expression true)))

   (check-equal? (evaluate-expression (make-add 1 2)) 3)
   (check-equal? (evaluate-expression (make-mul 1 2)) 2)
   (check-equal? (evaluate-expression (make-mul (make-add 3 4) 2)) 14)
   (check-exn exn? (lambda () (evaluate-expression (make-mul 1 'x))))
   (check-exn exn? (lambda () (evaluate-expression (make-mul false true))))
   (check-exn exn? (lambda () (evaluate-expression (make-mul (make-add empty 4) 2))))
   ))

(run-tests 14.4.3-tests)
