(define (make-singles xs) (map list xs))
(define (merge xs ys)
  (cond [(empty? xs) ys]
        [(empty? ys) xs]
        [(< (first xs) (first ys)) (cons (first xs) (merge (rest xs) ys))]
        [else (cons (first ys) (merge xs (rest ys)))]))

(define (merge-all-neighbors xss)
  (cond [(< (length xss) 2) xss]
        [else
          (cons (merge (first xss) (second xss))
                (merge-all-neighbors (drop xss 2)))]))

(define (merge-sort xs)
  (merge-until-done (make-singles xs)))

(define (merge-until-done xss)
  (cond [(empty? xss) empty]
        [(= (length xss) 1) (first xss)]
        [else (merge-until-done (merge-all-neighbors xss))]))


(require rackunit)
(require rackunit/text-ui)

(define merge-sort-tests
  (test-suite
   "Test for merge-sort"

   (test-case "make-singles"
    (check-equal? (make-singles '(1 2 3 4)) '((1) (2) (3) (4))))

   (test-case "merge"
    (check-equal? (merge '() '(3 9)) '(3 9))
    (check-equal? (merge '(2 5) '()) '(2 5))
    (check-equal? (merge '(2 5) '(3 9)) '(2 3 5 9))
    (check-equal? (merge '(3 9) '(2 5)) '(2 3 5 9)))

   (test-case "merge-all-neighbors"
     (check-equal? (merge-all-neighbors (list (list 2) (list 5) (list 9) (list 3)))
                   (list (list 2 5) (list 3 9)))
     (check-equal? (merge-all-neighbors (list (list 2 5) (list 3 9)))
                   (list (list 2 3 5 9))))

   (test-case "merge-sort"
    (check-equal? (merge-sort '()) '())
    (check-equal? (merge-sort '(1)) '(1))
    (check-equal? (merge-sort '(2 1)) '(1 2))
    (check-equal? (merge-sort '(2 5 9 3)) '(2 3 5 9)))

   ))

(exit (run-tests merge-sort-tests))
