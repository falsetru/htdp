(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define (g-fives i)
  (cond [(= i 0) 3]
        [else (* 5 (g-fives (sub1 i)))]))

(define (geometric-series start s)
  (local ((define (f i)
            (* start (expt s i))))
         f))


(require rackunit)
(require rackunit/text-ui)

(define sum-of-series-tests
  (test-suite "Test for sum-of-series"

   (check-equal? (series 3 g-fives) 468)
   (check-equal? (series 7 g-fives) 292968)
   (check-equal?
     (series 88 g-fives)
     121169035041947413311241507627435964877804508432745933532714843)

   (check-equal? (series 3 (geometric-series 1 1)) 4)
   (check-equal? (series 7 (geometric-series 1 1)) 8)
   (check-equal? (series 88 (geometric-series 1 1)) 89)
   ))

(exit (run-tests sum-of-series-tests))
