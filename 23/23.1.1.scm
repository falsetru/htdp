(define (make-even i)
  (* 2 i))

(define (make-odd i)
  (+ (* 2 i) 1))

(define (series-local a-term)
  (local ((define (series n)
          (cond [(= n 0) (a-term n)]
                [else (+ (a-term n)
                         (series (- n 1)))])))
         series))

(define series-even (series-local make-even))
(define series-odd (series-local make-odd))

(require rackunit)
(require rackunit/text-ui)

(define series-local-tests
  (test-suite "Test for series-local"

   (check-equal? (series-even 0) 0)
   (check-equal? (series-even 1) 2)
   (check-equal? (series-even 2) 6)
   (check-equal? (series-even 3) 12)
   (check-equal? (series-even 4) 20)

   (check-equal? (series-odd 0) 1)
   (check-equal? (series-odd 1) 4)
   (check-equal? (series-odd 2) 9)
   (check-equal? (series-odd 3) 16)
   (check-equal? (series-odd 4) 25)
   ))

(run-tests series-local-tests)
