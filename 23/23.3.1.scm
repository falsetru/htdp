(define (g-fives i)
  (cond [(= i 0) 3]
        [else (* 5 (g-fives (sub1 i)))]))

(require rackunit)
(require rackunit/text-ui)

(define g-fives-recursive-tests
  (test-suite
   "Test for g-fives-recursive"

   (check-equal? (g-fives 0) 3)
   (check-equal? (g-fives 1) 15)
   (check-equal? (g-fives 2) 75)
   ))

(exit (run-tests g-fives-recursive-tests))
