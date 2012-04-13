(define (a-five-closed i)
  (+ (+ 3 5) (* 5 i)))

(require rackunit)
(require rackunit/text-ui)

(define a-five-closed-tests
  (test-suite "Test for a-five-closed"

   (check-equal? (a-five-closed 0) 8)
   (check-equal? (a-five-closed 1) 13)
   (check-equal? (a-five-closed 2) 18)
   (check-equal? (a-five-closed 3) 23)
   ))

(run-tests a-five-closed-tests)
