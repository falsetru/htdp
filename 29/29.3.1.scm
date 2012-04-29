(define (neighbors orig graph)
  (vector-ref graph orig))

(require rackunit)
(require rackunit/text-ui)

(define neighbor-using-vector-tests
  (test-suite
   "Test for neighbor-using-vector"

   (test-case ""
    (define Graph-as-vector
      (vector (list 1 4)
              (list 4 5)
              (list 3)
              empty
              (list 2 5)
              (list 3 6)
              empty))
    (check-equal? (neighbors 0 Graph-as-vector) '(1 4))
    (check-equal? (neighbors 1 Graph-as-vector) '(4 5))
    (check-equal? (neighbors 2 Graph-as-vector) '(3))
    (check-equal? (neighbors 3 Graph-as-vector) '())
    (check-equal? (neighbors 4 Graph-as-vector) '(2 5))
    (check-equal? (neighbors 5 Graph-as-vector) '(3 6))
    (check-equal? (neighbors 6 Graph-as-vector) '())
    )
   (check-equal? 1 1)
   ))

(exit (run-tests neighbor-using-vector-tests))
