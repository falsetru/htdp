(define (add n x)
  (cond [(zero? n) x]
        [else (add (sub1 n) (add1 x))]))

(require rackunit)
(require rackunit/text-ui)

(define 11.5.1-tests
  (test-suite
   "Test for 11.5.1"

   (check-equal? (add 1 0) 1)
   (check-equal? (add 0 1) 1)
   (check-equal? (add 1 1) 2)
   ))

(run-tests 11.5.1-tests)
