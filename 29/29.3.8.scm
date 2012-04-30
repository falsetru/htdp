(define (vector-contains-doll? v)
  (local ((define (at i)
            (cond [(= i (vector-length v)) false]
                  [(symbol=? (vector-ref v i) 'doll) i]
                  [else (at (add1 i))])))
         (at 0)))

(require rackunit)
(require rackunit/text-ui)

(define vector-contains-doll?-tests
  (test-suite
   "Test for vector-contains-doll?"

   (check-equal? (vector-contains-doll? (vector 'doll 'car 'moon)) 0)
   (check-equal? (vector-contains-doll? (vector 'car 'moon 'doll)) 2)
   (check-equal? (vector-contains-doll? (vector 'car 'bus 'moon 'sun)) false)
   ))

(exit (run-tests vector-contains-doll?-tests))
