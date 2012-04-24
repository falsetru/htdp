(define (sub a b)
  (cond [(empty? a) empty]
        [else (cons (- (first b) (first a))
                    (sub (rest a) (rest b)))]))

(define (substract a b)
  (cond [(empty? a) empty]
        [else (local ((define subtracted (sub a b)))
                     (cond [(zero? (first subtracted)) (rest subtracted)]
                           [else (substract a subtracted)]))]))

(require rackunit)
(require rackunit/text-ui)

(define substract-tests
  (test-suite
   "Test for substract"

   (check-equal? (substract '(2 2 3 10) '(2 5 12 31))
                 '(3 9 21))
   (check-equal? (substract '(2 2 3 10) '(4 1 -2 1))
                 '(-3 -8 -19))
   ))

(exit (run-tests substract-tests))
