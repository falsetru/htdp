(define (abs-sort rel-op)
  (local ((define (concrete-sort alon)
	    (cond
	      [(empty? alon) empty]
	      [else (insert (first alon) (concrete-sort (rest alon)))]))
	  (define (insert an alon)
	    (cond
	      [(empty? alon) (list an)]
	      [else (cond
		      [(rel-op an (first alon)) (cons an alon)]
		      [else (cons (first alon) (insert an (rest alon)))])])))
    concrete-sort))

(define sort-asc (abs-sort <))
(define sort-dsc (abs-sort >))

(require rackunit)
(require rackunit/text-ui)

(define abstract-sort-tests
  (test-suite "Test for abstract-sort"
   (check-equal? (sort-asc '(3 7 6 2 9 8)) '(2 3 6 7 8 9))
   (check-equal? (sort-dsc '(3 7 6 2 9 8)) '(9 8 7 6 3 2))
   ))

(run-tests abstract-sort-tests)
