(define (find-root f left right tolerance)
  (cond
    [(<= (- right left) tolerance) left]
    [else 
      (local ((define mid (/ (+ left right) 2)))
	(cond
	  [(<= (f mid) 0 (f right)) 
           (find-root f mid right tolerance)]
	  [else 
           (find-root f left mid tolerance)]))]))

(define (poly x)
  (* (- x 2) (- x 4)))


(require rackunit)
(require rackunit/text-ui)

(define find-root-tests
  (test-suite
   "Test for find-root"

   (check-equal? (find-root poly 3 6 0.5) 15/4)
   (check-equal? (find-root poly 3 6 0.2) 63/16)
   (check-equal? (find-root poly 3 6 0.01) 1023/256)
   (check-equal? (find-root poly 3 6 0.000000001) 17179869183/4294967296)
   ))

(exit (run-tests find-root-tests))
