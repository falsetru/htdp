(define-struct posn (x y))

(define (line-from-point+slope point slope)
  (local ((define (f x)
            (+ (* slope x)
               (- (posn-y point)
                  (* slope (posn-x point))))))
         f))


(define (line-from-two-points p1 p2)
  (cond [(= (posn-x p1) (posn-x p2))
         (error "line-from-two-points: p1.x == p2.x")]
        [else
          (local ((define slope (/ (- (posn-y p2) (posn-y p1))
                                   (- (posn-x p2) (posn-x p1)))))
                 (line-from-point+slope p1 slope))]))

(require rackunit)
(require rackunit/text-ui)

(define line-from-two-points-tests
  (test-suite
   "Test for line-from-two-points"

   (test-case "Can't make line"
    (define (error-case)
      (line-from-two-points (make-posn 0 0) (make-posn 0 0)))
    (check-exn exn? error-case))

   (test-case "y = x"
    (define y (line-from-two-points (make-posn 0 0) (make-posn 1 1)))
    (check-equal? (y 0) 0)
    (check-equal? (y 1) 1)
    (check-equal? (y -1) -1))

   (test-case "y = -2x + 1"
    (define y (line-from-two-points (make-posn 0 1) (make-posn -2 5)))
    (check-equal? (y -2) 5)
    (check-equal? (y -1) 3)
    (check-equal? (y 0) 1)
    (check-equal? (y 1) -1)
    (check-equal? (y 2) -3))

   ))

(exit (run-tests line-from-two-points-tests))
