(require rackunit)
(require rackunit/text-ui)

(define VL 1024)
(define (g1 i) (- i 375))
(define (g2 i) (- 375 (* 2 i)))

(define (find-root-linear f left right)
  (cond [(= left right) left]
        [else
          (local ((define f-left (f left))
                  (define x (find-root-linear f (add1 left) right)))
                 (cond [(< (abs f-left) (abs (f x))) left]
                       [else x]))]))

(define (find-root-discrete f left right)
  (cond
    [(<= (- right left) 1)
     (if (< (abs (f left)) (abs (f right))) left right)]
    [else 
      (local ((define mid (floor (/ (+ left right) 2))))
	(cond
	  [(or (<= (f mid) 0 (f right))
               (<= (f right) 0 (f mid)))
           (find-root-discrete f mid right)]
	  [else (find-root-discrete f left mid)]))]))


(define find-root-linear-discrete-tests
  (test-suite
   "Test for find-root-linear-discrete"

   (check-equal? (find-root-linear g1 0 VL) 375)
   (check-equal? (find-root-linear g2 0 VL) 188)
   (check-equal? (find-root-discrete g1 0 VL) 375)
   (check-equal? (find-root-discrete g2 0 VL) 188)

   (test-case ""
    (define (check-all x)
      (cond [(= x VL) true]
            [else
              (check-equal? (find-root-discrete (lambda (i) (- i x)) 0 VL) x)
              (check-all (sub1 x))]))
    (check-all VL))

   ))

(exit (run-tests find-root-linear-discrete-tests))
