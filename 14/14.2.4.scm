(define-struct node (ssn name left right))

(define (search-bst n bst)
  (cond [(false? bst) false]
        [(< n (node-ssn bst)) (search-bst n (node-left bst))]
        [(> n (node-ssn bst)) (search-bst n (node-right bst))]
        [else (node-name bst)]))

(require rackunit)
(require rackunit/text-ui)

(define search-bst-tests
  (test-suite "Test for search-bst"

   (test-case ".."
    (define t
     (make-node 63 't63
       (make-node 29 't29
         (make-node 15 't15
           (make-node 10 't10 false false)
           (make-node 24 't24 false false))
         false)
       (make-node 89 't89
         (make-node 77 't77 false false)
         (make-node 95 't95
           false
           (make-node 99 't99 false false)))))

    (check-equal? (search-bst 63 t) 't63)
    (check-equal? (search-bst 29 t) 't29)
    (check-equal? (search-bst 15 t) 't15)
    (check-equal? (search-bst 10 t) 't10)
    (check-equal? (search-bst 24 t) 't24)
    (check-equal? (search-bst 89 t) 't89)
    (check-equal? (search-bst 77 t) 't77)
    (check-equal? (search-bst 95 t) 't95)
    (check-equal? (search-bst 99 t) 't99)
    (check-equal? (search-bst 1 t) false)
    (check-equal? (search-bst 30 t) false)
    (check-equal? (search-bst 76 t) false)
    (check-equal? (search-bst 100 t) false)
    )
   ))

(run-tests search-bst-tests)
