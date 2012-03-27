(define-struct node (ssn name left right))

(define (inorder bt)
  (cond [(false? bt) '()]
        [else (append
                (inorder (node-left bt))
                (list (node-ssn bt))
                (inorder (node-right bt)))]))

(require rackunit)
(require rackunit/text-ui)

(define inorder-tests
  (test-suite "Test for inorder"

   (test-case "left . right"
    (check-equal? 1 1)
    (define a (make-node 15 'd false (make-node 24 'i false false)))
    (define b (make-node 15 'd (make-node 87 'i false false) false))

    (check-equal? (inorder false) '())
    (check-equal? (inorder a) '(15 24))
    (check-equal? (inorder b) '(87 15))
    )
   ))

(run-tests inorder-tests)
