(define (merge a b)
  (cond [(empty? a) b]
        [(empty? b) a]
        [(< (first a) (first b)) (cons (first a) (merge (rest a) b))]
        [else (cons (first b) (merge a (rest b)))]
        ))

(require rackunit)
(require rackunit/text-ui)

(define merge-tests
  (test-suite "Test for merge"

   (check-equal? (merge (list) (list)) (list))
   (check-equal? (merge (list 1 3 5 7 9) (list)) (list 1 3 5 7 9))
   (check-equal? (merge (list) (list 0 2 4 6 8)) (list 0 2 4 6 8))
   (check-equal? (merge (list 1 3 5 7 9) (list 0 2 4 6 8)) (list 0 1 2 3 4 5 6 7 8 9))
   (check-equal? (merge (list 1 8 8 11 12) (list 2 3 4 8 13 14)) (list 1 2 3 4 8 8 8 11 12 13 14))
   ))

(run-tests merge-tests)
