(define (contains xs x)
  (cond [(empty? xs) false]
        [(= (first xs) x) true]
        [else (contains (rest xs) x)]))

(define (remove-all xs x)
  (cond [(empty? xs) xs]
        [(= (first xs) x) (rest xs)]
        [else (cons (first xs) (remove-all (rest xs) x))]))

(define (contains-same-numbers xs ys)
  (cond [(empty? xs) (empty? ys)]
        [else (and (contains ys (first xs))
                   (contains-same-numbers (rest xs)
                                          (remove-all ys (first xs))))]))


(require rackunit)
(require rackunit/text-ui)

(define contains-same-numbers-tests
  (test-suite
   "Test for contains-same-numbers"

   (check-equal? (contains-same-numbers '() '()) true)
   (check-equal? (contains-same-numbers '() '(1 2 3)) false)
   (check-equal? (contains-same-numbers '(1 2 3) '()) false)
   (check-equal? (contains-same-numbers '(1 2 3) '(1 2 3)) true)
   (check-equal? (contains-same-numbers '(1 2 3) '(3 2 1)) true)
   (check-equal? (contains-same-numbers '(1 2 3) '(4 2 1)) false)
   ))

(run-tests contains-same-numbers-tests)
