; (X (listof X)->Y) Y (listof X) -> Y
(define (fold f base xs)
  (cond [(empty? xs) base]
        [else (f (first xs)
                 (fold f base (rest xs)))]))

(define (sum alon) (fold + 0 alon))
(define (product alon) (fold * 1 alon))
(define (append a b) (fold cons b a))
(define (map f xs)
  (local ((define (cons-apply-f x xs)
            (cons (f x) xs)))
         (fold cons-apply-f empty xs)))


(require rackunit)
(require rackunit/text-ui)

(define fold-tests
  (test-suite
   "Test for fold"

   (check-equal? (sum '(1 2 3)) 6)
   (check-equal? (product '(1 2 3)) 6)
   (check-equal? (append '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))
   (check-equal? (map sub1 '(1 2 3)) '(0 1 2))
   ))

(run-tests fold-tests)
