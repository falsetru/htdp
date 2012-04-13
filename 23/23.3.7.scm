(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define (make-ln terms-count)
  (local
    ((define (ln x)
       (local ((define (ln-taylor i)
                 (local ((define j (+ (* 2 i) 1)))
                        (/ (expt (/ (- x 1)
                                    (+ x 1))
                                 j)
                           j))))
              (* 2 (series terms-count ln-taylor)))))
    ln))


(require rackunit)
(require rackunit/text-ui)

(define ln-tests
  (test-suite
   "Test for ln"

   (test-case "ln"
    (check-equal? (- (log 10) (exact->inexact ((make-ln 100) 10))) 0.0)
    (check-equal? (- (log 10) (exact->inexact ((make-ln 99) 10))) 0.0)
    (check-not-equal? (- (log 10) (exact->inexact ((make-ln 98) 10))) 0.0)
    )
   ))

(exit (run-tests ln-tests))
