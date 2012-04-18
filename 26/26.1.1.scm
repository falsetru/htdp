(define (tabulate-div n)
  (local ((define (iter-div i)
            (cond [(= i n) (list i)]
                  [(= (remainder n i) 0) (cons i (iter-div (add1 i)))]
                  [else (iter-div (add1 i))])))
         (iter-div 1)))

(require rackunit)
(require rackunit/text-ui)

(define tabulate-div-tests
  (test-suite
   "Test for tabulate-div"

   (check-equal? (tabulate-div 1) '(1))
   (check-equal? (tabulate-div 2) '(1 2))
   (check-equal? (tabulate-div 3) '(1 3))
   ))

(exit (run-tests tabulate-div-tests))
