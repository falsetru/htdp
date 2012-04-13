(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define (greg i)
  (local ((define j (+ (* 2 i) 1))
          (define sign (if (= (remainder i 2) 0) 1 -1)))
         (* sign (/ 1 j))))

(require rackunit)
(require rackunit/text-ui)

(define approximate-pi-tests
  (test-suite
   "Test for approximate-pi"

   (test-case
    "pi ~= approx-pi"
    (define approx-pi (exact->inexact (* 4 (series 1000 greg))))
    (check-true (< (abs (- pi approx-pi)) 0.001))
    )
   ))

(exit (run-tests approximate-pi-tests))
