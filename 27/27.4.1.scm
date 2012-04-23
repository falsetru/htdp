(define TOLERANCE 0.001)

(define (newton f r0)
  (cond
    [(<= (abs (f r0)) TOLERANCE) r0]
    [else (newton f (find-root-tangent f r0))]))

(define (find-root-tangent f r0)
  (local ((define fprime (d/dx f)))
    (- r0
       (/ (f r0)
	  (fprime r0)))))

(define (f x)
  (- (* x x) x 1.8))

(define (fprime x)
  (- (* 2 x) 1))

(define (d/dx f) fprime)    ; XXX


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

(printf "~s\n" (newton f 1)) ; 1.9318066879356328, 5 recursions
(printf "~s\n" (newton f 2)) ; 1.9317829457364342, 3 recursions
(printf "~s\n" (newton f 3)) ; 1.9318671188833911, 4 recursions
(printf "~s\n" (find-root f 0 5)) ; 15825/8192 (~= 1.9317626953125) 14 recursions
