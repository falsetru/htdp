(define-struct add (left right))
(define-struct mul (left right))

(define (evaluate-add x y) (+ (evaluate-expression x) (evaluate-expression y)))
(define (evaluate-mul x y) (* (evaluate-expression x) (evaluate-expression y)))

(define (evaluate-expression x)
  (cond [(number? x) x]
        [(add? x) (evaluate-add (add-left x) (add-right x))]
        [(mul? x) (evaluate-mul (mul-left x) (mul-right x))]
        [else (error "not a numeric expression")]))

(define (subst v n x)
  (cond [(number? x) x]
        [(symbol? x)
         (cond [(symbol=? x v) n]
               [else x])]
               ;[else (error "unknown symbol:" x)])]
        [(add? x) (make-add (subst v n (add-left x)) (subst v n (add-right x)))]
        [(mul? x) (make-mul (subst v n (mul-left x)) (subst v n (mul-right x)))]
        [else (error "not a valid expression")]))


(require rackunit)
(require rackunit/text-ui)

(define 14.4.4-tests
  (test-suite
   "Test for 14.4.4"

   (check-equal? (subst 'x 2 'x) 2)
   (check-equal?
     (evaluate-expression (subst 'x 2 (make-add 'x 1)))
     3)
   (check-exn
     exn?
     (lambda ()
       (evaluate-expression (subst 'x 2 (make-add 'x 'y)))))
   (check-equal?
     (evaluate-expression (subst 'y 3 (subst 'x 2
       (make-add 'x 'y))))
     5)
   (check-equal?
     (evaluate-expression (subst 'x 2
       (make-mul (make-add 'x 1) (make-mul 'x 'x))))
     12)
   ))

(run-tests 14.4.4-tests)
