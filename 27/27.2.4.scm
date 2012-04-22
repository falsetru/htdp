(define (create-matrix n numbers)
  (if (empty? numbers)
    empty
    (cons (take numbers n)
          (create-matrix n (drop numbers n)))))

(require rackunit)
(require rackunit/text-ui)

(define create-matrix-tests
  (test-suite
   "Test for create-matrix"

   (check-equal? (create-matrix 0 '())
                 '())

   (check-equal? (create-matrix 1 '(1))
                 '((1)))

   (check-equal? (create-matrix 2 '(1 2 3 4))
                 '((1 2) (3 4)))
   ))

(exit (run-tests create-matrix-tests))
