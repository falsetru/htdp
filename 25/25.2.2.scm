(define (quick-sort alon)
  (cond [(empty? alon) empty]
        [(empty? (rest alon)) alon]
        [else (append (quick-sort (smaller-items alon (first alon))) 
                      (list (first alon)) 
                      (quick-sort (larger-items alon (first alon))))]))


(define (larger-items alon threshold)
  (cond
    [(empty? alon) empty]
    [else (if (> (first alon) threshold) 
	      (cons (first alon) (larger-items (rest alon) threshold))
	      (larger-items (rest alon) threshold))]))

(define (smaller-items alon threshold)
  (cond
    [(empty? alon) empty]
    [else (if (< (first alon) threshold) 
	      (cons (first alon) (smaller-items (rest alon) threshold))
	      (smaller-items (rest alon) threshold))]))


(require rackunit)
(require rackunit/text-ui)

(define quick-sort-tests
  (test-suite
   "Test for quick-sort"

   (check-equal? (quick-sort '(11 9 2 18 12 14 4 1))
                 '(1 2 4 9 11 12 14 18))
   ))

(exit (run-tests quick-sort-tests))
