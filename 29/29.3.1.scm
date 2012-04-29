(define neighbors vector-ref)

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
    (check-equal? (neighbors Graph-as-vector 0) '(1 4))
    (check-equal? (neighbors Graph-as-vector 1) '(4 5))
    (check-equal? (neighbors Graph-as-vector 2) '(3))
    (check-equal? (neighbors Graph-as-vector 3) '())
    (check-equal? (neighbors Graph-as-vector 4) '(2 5))
    (check-equal? (neighbors Graph-as-vector 5) '(3 6))
    (check-equal? (neighbors Graph-as-vector 6) '())
    )
   (check-equal? 1 1)
   ))

(exit (run-tests neighbor-using-vector-tests))
