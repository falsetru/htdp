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

(define (blank n)
  (cond [(> n 0) (begin
                   (display " ")
                   (blank (sub1 n)))]))

(define (create-bst-from-list lonn)
  (cond [(empty? lonn) false]
        [else (create-bst (create-bst-from-list (rest lonn))
                          (first (first lonn))
                          (second (first lonn)))]))

(define (do-dump-tree t depth)
  (cond [(false? t) 'done]
        [else (begin
                (do-dump-tree (node-right t) (add1 depth))
                (blank depth)
                (display (node-ssn t))
                (newline)
                (do-dump-tree (node-left t) (add1 depth))
                )]))

(define (dump-tree t)
  (do-dump-tree t 0))

(require rackunit)
(require rackunit/text-ui)

(define create-bst-from-list-tests
  (test-suite "Test for create-bst-from-list"

   (test-case "sample"
    (define sample
      '((99 o)
        (77 l)
        (24 i)
        (10 h)
        (95 g)
        (15 d)
        (89 c)
        (29 b)
        (63 a)))

    (define t (create-bst-from-list sample))
    (define l node-left)
    (define r node-right)
    (define s node-ssn)
    (dump-tree t)
    (check-equal? (s          t   ) 63)
    (check-equal? (s       (l t)  ) 29)
    (check-equal? (r       (l t)  ) false)
    (check-equal? (s    (l (l t)) ) 15)
    (check-equal? (s (l (l (l t)))) 10)
    (check-equal? (l (l (l (l t)))) false)
    (check-equal? (r (l (l (l t)))) false)
    (check-equal? (s (r (l (l t)))) 24)
    (check-equal? (l (r (l (l t)))) false)
    (check-equal? (r (r (l (l t)))) false)
    (check-equal? (s       (r t)  ) 89)
    (check-equal? (s    (l (r t)) ) 77)
    (check-equal? (s    (r (r t)) ) 95)
    (check-equal? (s (r (r (r t)))) 99)
    (check-equal? (l (r (r (r t)))) false)
    (check-equal? (r (r (r (r t)))) false)
    )
   ))

(run-tests create-bst-from-list-tests)
