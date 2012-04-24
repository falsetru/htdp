(define (evaluate eq known-values)
  (cond [(empty? known-values) (- (first eq))]
        [else (+ (+ (* (first eq) (first known-values)))
                 (evaluate (rest eq) (rest known-values)))]))

(define (solve-one eq known-values)
  (cons
    (/ (- (evaluate (rest eq) known-values)) (first eq))
    known-values))

(define (do-solve eqs known-values)
  (cond [(empty? (rest eqs))
         (solve-one (first eqs)
                    known-values)]
        [else
          (solve-one (first eqs)
                     (do-solve (rest eqs) known-values))]))

(define (solve eqs)
  (do-solve eqs '()))

(require rackunit)
(require rackunit/text-ui)

(define solve-tests
  (test-suite
   "Test for solve"

   (check-equal? (evaluate '(1) '()) -1)
   (check-equal? (evaluate '(9 21) '(2)) -3)
   (check-equal? (evaluate '(9 1 24) '(2 3)) -3)

   (check-equal? (solve-one '(3 9 21) '(2)) '(1 2))

   (check-equal? (solve '((2 3 3 8)
                          (-8 -4 -12)
                          (-5 -5)))
                 '(1 1 1))

   (check-equal? (solve '((2 2 3 10)
                          (  3 9 21)
                          (    1  2)))
                 '(1 1 2))
   ))

(exit (run-tests solve-tests))
