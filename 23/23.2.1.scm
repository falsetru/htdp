(define (a-five i)
  (cond [(= i 0) (+ 3 5)]
        [else (+ (a-five (- i 1)) 5)]))
(require rackunit)
(require rackunit/text-ui)

(define a-five-recursive-tests
  (test-suite
   "Test for a-five-recursive"

   (check-equal? (a-five 0) 8)
   (check-equal? (a-five 1) 13)
   (check-equal? (a-five 2) 18)
   (check-equal? (a-five 3) 23)
   ))

(run-tests a-five-recursive-tests)
