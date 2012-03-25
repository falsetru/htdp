(define-struct tree (name value left right))

(define (tree=? a b)
  (cond [(false? a ) (false? b)]
        [else
          (and (tree? b)
               (symbol=? (tree-name a) (tree-name b))
               (= (tree-value a) (tree-value b))
               (tree=? (tree-left a) (tree-left b))
               (tree=? (tree-right b) (tree-right b)))]))

(require rackunit)
(require rackunit/text-ui)

(define tree-equal-tests
  (test-suite "Test for tree-equal"

   (test-case "tree=?"
    (define a (make-tree 'a 10 false false))
    (define b (make-tree 'b 20 false false))
    (define c (make-tree 'c 30 a false))
    (define d (make-tree 'd 30 a false))
    (define e (make-tree 'e 30 a b))
    (define w (make-tree 'w 99 false false))
    (define y (make-tree 'y 13 w false))
    (define z (make-tree 'z 22 false false))
    (define x (make-tree 'x 23 y z))

    (check-equal? (tree=? a a) true)
    (check-equal? (tree=? a b) false)
    (check-equal? (tree=? c d) false)
    (check-equal? (tree=? e e) true)
    (check-equal? (tree=? x x) true)
    (check-equal? (tree=? x z) false)
    (check-equal? (tree=? w x) false)

    )
   ))

(run-tests tree-equal-tests)
