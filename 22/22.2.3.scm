(define (abs-fold base f)
  (local ((define (concrete-fold xs)
            (cond [(empty? xs) base]
                  [else (f (first xs)
                           (concrete-fold (rest xs)))])))
         concrete-fold))

(define sum (abs-fold 0 +))
(define product (abs-fold 1 *))

(require rackunit)
(require rackunit/text-ui)

(define fold-tests
  (test-suite "Test for fold"

   (check-equal? (sum '(1 2 3)) 6)
   (check-equal? (product '(1 2 3 4)) 24)
   ))

(run-tests fold-tests)
