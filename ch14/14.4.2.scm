(define-struct add (left right))
(define-struct mul (left right))

(define (numeric? x)
  (or (number? x)
      (symbol? x)
      (and (add? x) (numeric? (add-left x)) (numeric? (add-right x)))
      (and (mul? x) (numeric? (mul-left x)) (numeric? (mul-right x)))))

(require rackunit)
(require rackunit/text-ui)

(define 14.4.2-tests
  (test-suite
   "Test for 14.4.2"

   (check-equal? (numeric? 1) true)
   (check-equal? (numeric? 'x) true)
   (check-equal? (numeric? (make-add 1 2)) true)
   (check-equal? (numeric? (make-mul 1 2)) true)
   (check-equal? (numeric? empty) false)
   (check-equal? (numeric? false) false)
   (check-equal? (numeric? true) false)
   (check-equal? (numeric? (make-mul (make-add 3 4) 2)) true)
   (check-equal? (numeric? (make-mul false true)) false)
   (check-equal? (numeric? (make-mul (make-add empty 4) 2)) false)
   ))

(run-tests 14.4.2-tests)
