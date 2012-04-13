(define (! n)
  (cond
    [(= n 0) 1]
    [else (* n (! (sub1 n)))]))

(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define (my-sin x)
  (local
    ((define (sin-taylor i)
       (local ((define j (+ (* 2 i) 1))
               (define sign (if (= (remainder i 2) 0) 1 -1)))
              (* sign
                 (/ (expt x j)
                    (! j))))))
    (series 100 sin-taylor)))

(require rackunit)
(require rackunit/text-ui)

(define my-sin-tests
  (test-suite "Test for my-sin"

   (test-case "exact enough"
    (define epsilon 0.000000000000001)
    (check-equal? (my-sin 0) 0)
    (check-true (< (- (my-sin (/ pi 2)) 1) epsilon))
    (check-true (< (- (my-sin pi) 0) epsilon)))
   ))

(exit (run-tests my-sin-tests))
