(define-struct node (ssn name left right))

(define (contains-bt number bt)
  (cond [(false? bt) false]
        [(= (node-ssn bt) number) true]
        [else (or (contains-bt number (node-left bt))
                  (contains-bt number (node-right bt)))]))

(require rackunit)
(require rackunit/text-ui)

(define contains-bt-tests
  (test-suite "Test for contains-bt"

   (test-case "."
    (check-equal? 1 1)
    (define a (make-node 15 'd false (make-node 24 'i false false)))
    (define b (make-node 15 'd (make-node 87 'i false false) false))

    (check-equal? (contains-bt 15 false) false)
    (check-equal? (contains-bt 15 a) true)
    (check-equal? (contains-bt 24 a) true)
    (check-equal? (contains-bt 24 b) false)
    (check-equal? (contains-bt 87 a) false)
    (check-equal? (contains-bt 87 b) true)
    )
   ))

(run-tests contains-bt-tests)
