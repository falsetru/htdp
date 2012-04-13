(define (a-fives i)
  (cond [(= i 0) (+ 3 5)]
        [else (+ (a-fives (- i 1)) 5)]))
(require rackunit)
(require rackunit/text-ui)

(define a-fives-recursive-tests
  (test-suite
   "Test for a-fives-recursive"

   (check-equal? (a-fives 0) 8)
   (check-equal? (a-fives 1) 13)
   (check-equal? (a-fives 2) 18)
   (check-equal? (a-fives 3) 23)
   ))

(run-tests a-fives-recursive-tests)
