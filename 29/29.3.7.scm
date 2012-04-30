(define (norm v)
  (local ((define (sq-sum i)
          (cond [(= i (vector-length v)) 0]
                [else (+ (sqr (vector-ref v i))
                         (sq-sum (add1 i)))])))
         (sqrt (sq-sum 0))))

(require rackunit)
(require rackunit/text-ui)

(define norm-tests
  (test-suite
   "Test for norm"

   (check-equal? (norm (vector 3 4)) 5)
   (check-equal? (norm (vector 1)) 1)
   (check-equal? (norm (vector)) 0)
   ))

(exit (run-tests norm-tests))
