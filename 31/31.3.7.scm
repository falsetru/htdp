;(define (to10 alon)
;  (local ((define (to10-a alon acc)
;            (cond [(empty? alon) acc]
;                  [else (to10-a (rest alon) (+ (first alon)
;                                               (* 10 acc)))])))
;         (to10-a alon 0)))
(define (to10 alon)
  (to10-general 10 alon))

(define (to10-general base alon)
  (local ((define (to10-a alon acc)
            (cond [(empty? alon) acc]
                  [else (to10-a (rest alon) (+ (first alon)
                                               (* base acc)))])))
         (to10-a alon 0)))

(require rackunit)
(require rackunit/text-ui)

(define to10-tests
  (test-suite
   "Test for to10"

   (check-equal? (to10 '(1 0 2)) 102)
   (check-equal? (to10 '(2 1)) 21)
   (check-equal? (to10-general 10 '(1 0 2)) 102)
   (check-equal? (to10-general 10 '(2 1)) 21)
   (check-equal? (to10-general 8 '(3 3)) 27)
   (check-equal? (to10-general 2 '(1 1 1 1 1 1 1 1)) 255)
   ))

(exit (run-tests to10-tests))
