(define (vector-sum v)
  (local ((define (vector-sum-aux i)
            (cond [(zero? i) 0]
                  [else (+ (vector-ref v (sub1 i))
                           (vector-sum-aux (sub1 i)))])))
         (vector-sum-aux (vector-length v))))

(require rackunit)
(require rackunit/text-ui)

(define vector-sum-tests
  (test-suite
   "Test for vector-sum"

   (check-equal? (vector-sum (vector -1 3/4 1/4)) 0)
   ))

(exit (run-tests vector-sum-tests))
