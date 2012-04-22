(define TOLERANCE 0.5)

(define (find-root f left right)
  (cond
    [(<= (- right left) TOLERANCE) left]
    [else 
      (local ((define mid (/ (+ left right) 2)))
	(cond
	  [(<= (f mid) 0 (f right)) 
           (find-root f mid right)]
	  [else 
           (find-root f left mid)]))]))

(define (poly x)
  (* (- x 2) (- x 4)))


(require rackunit)
(require rackunit/text-ui)

(define find-root-tests
  (test-suite
   "Test for find-root"

   (check-equal? (find-root poly 3 6) 15/4)
   ))

(exit (run-tests find-root-tests))
