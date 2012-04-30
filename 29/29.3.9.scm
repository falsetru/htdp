(define (binary-contains? v key)
  (local ((define (between i j)
            (local
              ((define m (floor (/ (+ i j) 2)))
               (define x (vector-ref v m)))
              (cond [(>= i j) false]
                    [(= key x) m]
                    [(= i m) false]
                    [(< key x) (between i m)]
                    [else (between m j)]))))
         (between 0 (vector-length v))))

(require rackunit)
(require rackunit/text-ui)

(define binary-contains?-tests
  (test-suite
   "Test for binary-contains?"

   (check-equal? (binary-contains? (vector 0 1 2) 0) 0)
   (check-equal? (binary-contains? (vector 0 1 2) 1) 1)
   (check-equal? (binary-contains? (vector 0 1 2) 2) 2)
   (check-equal? (binary-contains? (vector 0 1 2) 3) false)
   (check-equal? (binary-contains? (vector 0 1 2) -1) false)
   (check-equal? (binary-contains? (vector 0 1) 0) 0)
   (check-equal? (binary-contains? (vector 0 1) 1) 1)
   (check-equal? (binary-contains? (vector 0 1) -1) false)
   (check-equal? (binary-contains? (vector 0 1) 2) false)
   ))

(exit (run-tests binary-contains?-tests))
