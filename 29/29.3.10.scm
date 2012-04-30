(define (vector-count v s)
  (local ((define (at i)
            (cond [(= i (vector-length v)) 0]
                  [(symbol=? (vector-ref v i) s)
                   (+ 1 (at (add1 i)))]
                  [else (at (add1 i))])))
         (at 0)))

(require rackunit)
(require rackunit/text-ui)

(define vector-count-tests
  (test-suite
   "Test for vector-count"

   (check-equal? (vector-count (vector 'one 'two 'three 'two) 'two) 2)
   (check-equal? (vector-count (vector 'one 'two 'three 'two) 'four) 0)
   ))

(exit (run-tests vector-count-tests))
