(define (id-vector n)
  (build-vector n (lambda (i) 1)))

(require rackunit)
(require rackunit/text-ui)

(define id-vector-tests
  (test-suite
   "Test for id-vector"

   (check-equal? (id-vector 3) (vector 1 1 1))
   ))

(exit (run-tests id-vector-tests))
