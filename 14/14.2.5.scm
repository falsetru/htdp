(define-struct node (ssn name left right))

(define (create-bst B N S)
  (cond [(false? B) (make-node N S false false)]
        [(< N (node-ssn B))
         (make-node (node-ssn B)
                    (node-name B)
                    (create-bst (node-left B) N S)
                    (node-right B))]
        [(> N (node-ssn B))
         (make-node (node-ssn B)
                    (node-name B)
                    (node-left B)
                    (create-bst (node-right B) N S))]))

(require rackunit)
(require rackunit/text-ui)

(define create-bst-tests
  (test-suite "Test for create-bst"

   (test-case ""
    (define t (create-bst (create-bst false 66 'a) 53 'b))
    (check-equal? (node-ssn t) 66)
    (check-equal? (node-name t) 'a)
    (check-equal? (node-right t) false)
    (check-equal? (node-ssn (node-left t)) 53)
    (check-equal? (node-name (node-left t)) 'b)
    (check-equal? (node-left (node-left t)) false)
    (check-equal? (node-right (node-left t)) false)
    )
   ))

(run-tests create-bst-tests)
