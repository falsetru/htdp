(define (neighbors orig g)
  (second (assoc orig g)))

(require rackunit)
(require rackunit/text-ui)

(define neighbors-tests
  (test-suite "Test for neighbors"
   (test-case "neighbors"
    (define Graph 
      '((A (B E))
        (B (E F))
        (C (D))
        (D ())
        (E (C F))
        (F (D G))
        (G ())))
    (check-equal? (neighbors 'B Graph) '(E F))
    (check-equal? (neighbors 'D Graph) '())
    )
   ))

(exit (run-tests neighbors-tests))
