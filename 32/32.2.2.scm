(define-struct side (m c) #:transparent)  ; m, c: number

(define (make-BOAT-LOADS n)
  (local ((define (mk m c)
            (cond [(> m n) empty]
                  [(> (+ m c) n) (mk (add1 m) 0)]
                  [else (cons (make-side m c)
                              (mk m (add1 c)))])))
         (mk 0 1)))

(define BOAT-LOADS (make-BOAT-LOADS 2))

(require rackunit)
(require rackunit/text-ui)

(define boat-loads-tests
  (test-suite
   "Test for boat-loads"

   (check-equal? BOAT-LOADS
                 (list (make-side 0 1)
                       (make-side 0 2)
                       (make-side 1 0)
                       (make-side 1 1)
                       (make-side 2 0)))
   ))

(exit (run-tests boat-loads-tests))
