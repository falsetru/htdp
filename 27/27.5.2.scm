(define (multiply lst x)
  (map (lambda (y) (* x y)) lst))

(define (sub a b)
  (cond [(empty? a) empty]
        [else (cons (- (first b) (first a))
                    (sub (rest a) (rest b)))]))

(define (substract a b)
  (cond [(empty? a) empty]
        [else
          (local ((define a-prime (multiply a (/ (first b) (first a)))))
                 (rest (sub a-prime b)))]))

(require rackunit)
(require rackunit/text-ui)

(define substract-tests
  (test-suite
   "Test for substract"

   (check-equal? (multiply '(-3 -8 -19) -1)
                 '(3 8 19))
   (check-equal? (substract '(3 9 21) '(-3 -8 -19))
                 '(1 2))
   (check-equal? (substract '(2 2 3 10) '(2 5 12 31))
                 '(3 9 21))
   (check-equal? (substract '(2 2 3 10) '(4 1 -2 1))
                 '(-3 -8 -19))))

(exit (run-tests substract-tests))
