(define (geometric-series start s)
  (local ((define (f i)
            (* start (expt s i))))
         f))

(define g-fives (geometric-series 3 5))

(require rackunit)
(require rackunit/text-ui)

(define geometric-series-tests
  (test-suite "Test for geometric-series"
   (check-equal? (g-fives 0) 3)
   (check-equal? (g-fives 1) 15)
   (check-equal? (g-fives 2) 75)
   ))

(exit (run-tests geometric-series-tests))
