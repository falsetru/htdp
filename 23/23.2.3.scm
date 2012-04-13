(define (a-fives i)
  (+ (+ 3 5) (* 5 i)))

(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(require rackunit)
(require rackunit/text-ui)

(define series-tests
  (test-suite "Test for series"

   (check-equal? (series 3 a-fives) 62)
   (check-equal? (series 7 a-fives) 204)
   (check-equal? (series 88 a-fives) 20292)
   ))

(run-tests series-tests)
