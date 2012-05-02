;(define (add-to-pi n)
;  (local ((define (add-to-pi-a n acc)
;            (cond [(zero? n) acc]
;                  [else (add-to-pi-a (sub1 n) (add1 acc))])))
;         (add-to-pi-a n pi)))

(define (add-to-pi n)
  (add n pi))

(define (add x y)
  (local ((define (add-to-pi-a n acc)
            (cond [(zero? n) acc]
                  [else (add-to-pi-a (sub1 n) (add1 acc))])))
         (add-to-pi-a x y)))


(require rackunit)
(require rackunit/text-ui)

(define add-to-pi-tests
  (test-suite
   "Test for add-to-pi"

   (test-case
    "add-to-pi"
    (check-equal? (add-to-pi 0) pi)
    (check-equal? (add-to-pi 5) (+ pi 5))
    )

   (test-case
    "add"
    (check-equal? (add 0 3.5) 3.5)
    (check-equal? (add 1 3.5) (+ 1 3.5))
    (check-equal? (add 997 3.5) (+ 997 3.5))
    )
   ))

(exit (run-tests add-to-pi-tests))
