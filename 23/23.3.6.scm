(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define (difference how-many-times)
  (local ((define (e-power x)
            (local ((define (e-taylor i)
                      (/ (expt x i) (! i)))
                    (define (! n)
                      (cond
                        [(= n 0) 1]
                        [else (* n (! (sub1 n)))])))
                   (series how-many-times e-taylor)))
          (define p1 (exp 1))
          (define p2 (exact->inexact (e-power 1))))
         (- p1 p2)))

(define (solve n small-enough?)
  (cond [(small-enough? (difference n)) n]
        [else (solve (add1 n) small-enough?)]))


(require rackunit)
(require rackunit/text-ui)

(define find-terms-count-tests
  (test-suite "Test for find-terms-count"

   (test-case "0.0000000000001"
    (define (small-enough? x) (< (abs x) 0.0000000000001))
    (check-equal? (solve 0 small-enough?) 15))
   ))

(exit (run-tests find-terms-count-tests))
