(define (is-prime? n)
  (local ((define (af i acc)
            (cond [(= i 1) acc]
                  [else (af (sub1 i) (and acc
                                          (not (zero? (remainder n i)))))])))
          (af (sub1 n) true)))

(require rackunit)
(require rackunit/text-ui)

(define is-prime?-tests
  (test-suite
   "Test for is-prime?"

   (check-equal? (is-prime? 2) true)
   (check-equal? (is-prime? 3) true)
   (check-equal? (is-prime? 4) false)
   (check-equal? (is-prime? 5) true)
   (check-equal? (is-prime? 6) false)
   (check-equal? (is-prime? 7) true)
   (check-equal? (is-prime? 8) false)
   (check-equal? (is-prime? 9) false)
   (check-equal? (is-prime? 10) false)
   (check-equal? (is-prime? 11) true)
   ))

(exit (run-tests is-prime?-tests))
