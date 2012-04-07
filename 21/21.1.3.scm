; natural-f: (X Y -> Y) Y number X -> Y
(define (natural-f f base n x)
  (cond [(zero? n) base]
        [else (f x
                 (natural-f f base (sub1 n) x))]))

(define (copy n obj)
  (natural-f cons empty n obj))

(define (n-adder n x)
  (natural-f + x n 1))

(define (n-multiplier n x)
  (natural-f + 0 n x))


(require rackunit)
(require rackunit/text-ui)

(define natural-f-tests
  (test-suite "Test for natural-f"

   (check-equal? (copy 5 'a) '(a a a a a))
   (check-equal? (n-adder 10 5) 15)
   (check-equal? (n-multiplier 5 9) 45)
   ))

(run-tests natural-f-tests)
