(define-struct posn (x y))
(define (line-from-point+slope point slope)
  (local ((define (f x)
            (+ (* slope x)
               (- (posn-y point)
                  (* slope (posn-x point))))))
         f))


(require rackunit)
(require rackunit/text-ui)

(define line-from-point+slope-tests
  (test-suite "Test for line-from-point+slope"
   (test-case "y = x + 4"
    (define f (line-from-point+slope (make-posn 0 4) 1))
    (check-equal? (f -2) 2)
    (check-equal? (f -1) 3)
    (check-equal? (f 0) 4)
    (check-equal? (f 1) 5)
    (check-equal? (f 2) 6))
   ))

(exit (run-tests line-from-point+slope-tests))
