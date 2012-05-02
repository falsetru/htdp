(define (make-palindrome xs)
  (local ((define r (reverse xs))
          (define (palindrome-a xs acc)
            (cond [(empty? xs) acc]
                  [else (palindrome-a (rest xs) (cons (first xs) acc))])))
         (palindrome-a (rest r) r)))

(require rackunit)
(require rackunit/text-ui)

(define make-palindrome-tests
  (test-suite
   "Test for make-palindrome"

   (check-equal? (make-palindrome '(a)) '(a))
   (check-equal? (make-palindrome '(a b c)) '(a b c b a))
   ))

(exit (run-tests make-palindrome-tests))
