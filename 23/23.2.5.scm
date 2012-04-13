(define (arithmetic-series start s)
  (local ((define (f i)
            (cond [(= i 0) start]
                  [else (+ start (* s i))])))
         f))

(require rackunit)
(require rackunit/text-ui)

(define arithmetic-series-tests
  (test-suite "Test for arithmetic-series"

   (test-case "a-fives evens"
    (define a-fives (arithmetic-series 3 5))
    (define evens (arithmetic-series 0 2))
    (check-equal? (a-fives 0) 3)
    (check-equal? (a-fives 1) 8)
    (check-equal? (a-fives 2) 13)
    (check-equal? (evens 0) 0)
    (check-equal? (evens 1) 2)
    (check-equal? (evens 2) 4))
   ))

(exit (run-tests arithmetic-series-tests))
