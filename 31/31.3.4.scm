(define (how-many xs)
  (local ((define (how-many-a xs acc)
            (cond [(empty? xs) acc]
                  [else (how-many-a (rest xs) (add1 acc))])))
         (how-many-a xs 0)))

(require rackunit)
(require rackunit/text-ui)

(define how-many-tests
  (test-suite
   "Test for how-many"

   (check-equal? (how-many '()) 0)
   (check-equal? (how-many '(4)) 1)
   (check-equal? (how-many '(1 2 3 4 9)) 5)
   ))

(exit (run-tests how-many-tests))
