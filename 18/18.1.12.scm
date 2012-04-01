(define (maxi alon)
  (cond [(empty? (rest alon)) (first alon)]
        [else
          (local ((define m (maxi (rest alon)))
                  (define f (first alon)))
                 (cond [(> f m) f]
                       [else m]))]))

(require rackunit)
(require rackunit/text-ui)

(define maxi-tests
  (test-suite "Test for maxi"

   (check-equal? (maxi (list 9)) 9)
   (check-equal? (maxi (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)) 20)
   (check-equal? (maxi (list 5 4 3 2 1)) 5)
   (check-equal? (maxi (list 2 4 6 1 3 1)) 6)
   ))

(run-tests maxi-tests)
