(define TOLERANCE 0.5)

(define (find-root f left right)
  (find-root-aux f left right (f left) (f right)))

(define (find-root-aux f left right f-left f-right)
  (cond
    [(<= (- right left) TOLERANCE) left]
    [else 
      (local ((define mid (/ (+ left right) 2))
              (define f-mid (f mid)))
	(cond
	  [(<= f-mid 0 f-right) 
           (find-root-aux f mid right f-mid f-right)]
	  [else 
           (find-root-aux f left mid f-left f-mid)]))]))


(define (poly x)
  (* (- x 2) (- x 4)))


(require rackunit)
(require rackunit/text-ui)

(define find-root-aux-tests
  (test-suite
   "Test for find-root"

   (check-equal? (find-root poly 3 6) 15/4)
   ))

(exit (run-tests find-root-aux-tests))
