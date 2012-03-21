(define (add n x)
  (cond [(zero? n) x]
        [else (add (sub1 n) (add1 x))]))

(define (multiply a b)
  (cond [(zero? b) 0]
        [(= b 1) a]
        [else (add a (multiply a (sub1 b)))]))

(define (multiply-by-pi n)
  (/ (multiply 314.0 n) 100))   ; XXX /

(require rackunit)
(require rackunit/text-ui)

(define 11.5.2-tests
  (test-suite
   "Test for 11.5.2"

   (check-equal? (multiply-by-pi 0) 0)
   (check-equal? (multiply-by-pi 2) 6.28)
   (check-equal? (multiply-by-pi 3) 9.42)

   (check-equal? (multiply 0 1) 0)
   (check-equal? (multiply 1 0) 0)
   (check-equal? (multiply 1 3) 3)
   ))

(run-tests 11.5.2-tests)
