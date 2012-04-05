(define (last xs)
  (cond [(empty? (rest xs)) (first xs)]
        [else (last (rest xs))]))

(require rackunit)
(require rackunit/text-ui)

(define last-tests
  (test-suite
   "Test for last"

   (check-equal? (last '(2)) 2)
   (check-equal? (last '(1 2 3)) 3)
   ))

(run-tests last-tests)
