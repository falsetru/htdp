(define (general-quick-sort a-predicate a-list)
  (cond [(empty? a-list) empty]
        [else
          (local ((define pivot (first a-list))
                  (define xs (rest a-list))
                  (define pred (lambda (x) (a-predicate x pivot)))
                  (define neg (lambda (x) (not (pred x)))))
                 (append (general-quick-sort a-predicate (filter pred xs))
                         (list pivot)
                         (general-quick-sort a-predicate (filter neg  xs))))]))

(require rackunit)
(require rackunit/text-ui)

(define general-quick-sort-tests
  (test-suite
   "Test for general-quick-sort"

   (check-equal? (general-quick-sort < '(11 9 2 18 12 14 4 1))
                 '(1 2 4 9 11 12 14 18))
   (check-equal? (general-quick-sort < '(1 2 3 1 2 3 1 2 3))
                 '(1 1 1 2 2 2 3 3 3))
   (check-equal? (general-quick-sort > '(1 2 3 1 2 3 1 2 3))
                 '(3 3 3 2 2 2 1 1 1))
   (check-equal? (general-quick-sort
                   (lambda (x y) (< (string-length x) (string-length y)))
                   (list "AA" "C" "BBB"))
                 (list "C" "AA" "BBB"))
   ))

(exit (run-tests general-quick-sort-tests))
