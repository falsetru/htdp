(define (lr-vector-sum v)
  (local ((define (vector-sum-aux i)
            (cond [(= i (vector-length v)) 0]
                  [else (+ (vector-ref v i)
                           (vector-sum-aux (add1 i)))])))
         (vector-sum-aux 0)))

(require rackunit)
(require rackunit/text-ui)

(define lr-vector-sum-tests
  (test-suite
   "Test for lr-vector-sum"

   (check-equal? (lr-vector-sum (vector -1 3/4 1/4)) 0)
   ))

(exit (run-tests lr-vector-sum-tests))
