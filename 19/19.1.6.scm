(define (sort alon rel-op)
  (local ((define (sort alon)
            (cond [(empty? alon) empty]
                  [else (insert (first alon) (sort (rest alon)))]))
          (define (insert an alon)
            (cond [(empty? alon) (list an)]
                  [else (cond [(rel-op an (first alon)) (cons an alon)]
                              [else (cons (first alon)
                                          (insert an (sort (rest alon))))])])))
         (sort alon)))

(require rackunit)
(require rackunit/text-ui)

(define sort-tests
  (test-suite "Test for sort"
   (test-case ""
    (define sample (list 2 3 1 5 4))
    (check-equal? (sort empty <) empty)
    (check-equal? (sort empty >) empty)
    (check-equal? (sort sample <) (list 1 2 3 4 5))
    (check-equal? (sort sample >) (list 5 4 3 2 1))
    )
   ))

(run-tests sort-tests)
