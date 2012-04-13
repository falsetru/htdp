(define (g-fives-closed i)
  (* 3 (expt 5 i)))

(require rackunit)
(require rackunit/text-ui)

(define g-fives-closed-tests
  (test-suite
   "Test for g-fives-closed"

   (check-equal? (g-fives-closed 0) 3)
   (check-equal? (g-fives-closed 1) 15)
   (check-equal? (g-fives-closed 2) 75)
   ))

(exit (run-tests g-fives-closed-tests))
