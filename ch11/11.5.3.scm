(define (add n x)
  (cond [(zero? n) x]
        [else (add (sub1 n) (add1 x))]))

(define (multiply a b)
  (cond [(zero? b) 0]
        [(= b 1) a]
        [else (add a (multiply a (sub1 b)))]))

(define (exponent x n)
  (cond [(zero? n) 1]
        [else (mul (exponent x (sub1 n)) x)]))

(require rackunit)
(require rackunit/text-ui)

(define 11.5.3-tests
  (test-suite
   "Test for 11.5.3"

   (check-equal? (exponent 2 0) 1)
   (check-equal? (exponent 2 1) 2)
   (check-equal? (exponent 2 10) 1024)
   (check-equal? (exponent 3 3) 27)
   ))

(run-tests 11.5.3-tests)
