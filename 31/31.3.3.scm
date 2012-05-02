(define (product alon)
  (local ((define (product-a alon acc)
            (cond [(empty? alon) acc]
                  [else (product-a (rest alon) (* acc (first alon)))])))
         (product-a alon 1)))


(require rackunit)
(require rackunit/text-ui)

(define product-tests
  (test-suite
   "Test for product"

   (check-equal? (product '()) 1)
   (check-equal? (product '(3)) 3)
   (check-equal? (product '(1 2 3 4 5)) 120)
   (check-equal? (product '(1 2 3 4 5)) 120)
   ))

(exit (run-tests product-tests))
