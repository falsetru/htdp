(define (a-fives-closed i)
  (+ (+ 3 5) (* 5 i)))

(require rackunit)
(require rackunit/text-ui)

(define a-fives-closed-tests
  (test-suite "Test for a-fives-closed"

   (check-equal? (a-fives-closed 0) 8)
   (check-equal? (a-fives-closed 1) 13)
   (check-equal? (a-fives-closed 2) 18)
   (check-equal? (a-fives-closed 3) 23)
   ))

(run-tests a-fives-closed-tests)
