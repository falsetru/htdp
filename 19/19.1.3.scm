(define (filter predicate alon)
  (cond
    [(empty? alon) empty]
    [else (cond
	    [(predicate (first alon)) 
	     (cons (first alon)
	       (filter predicate (rest alon)))]
	    [else
	     (filter predicate (rest alon))])]))

(define (below alon t) (local ((define (f x) (< x t))) (filter f alon)))
(define (above alon t) (local ((define (f x) (> x t))) (filter f alon)))

(require rackunit)
(require rackunit/text-ui)

(define below-above-using-filter-tests
  (test-suite
   "Test for below-above-using-filter"

   (check-equal? 1 1)
   (test-case
    ""
    (define xs '(1 2 3 4 5 6 7))
    (check-equal? (below xs 4) '(1 2 3))
    (check-equal? (above xs 4) '(5 6 7))
    (check-equal? (below xs 0) '())
    (check-equal? (below xs 8) xs)
    (check-equal? (above xs 0) xs)
    (check-equal? (above xs 8) '())
    )
   ))

(run-tests below-above-using-filter-tests)
