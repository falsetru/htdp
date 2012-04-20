(define (gcd-generative n m)
  (local ((define (clever-gcd larger smaller)
	    (cond
	      [(= smaller 0) larger]
	      [else (clever-gcd smaller (remainder larger smaller))])))
    (clever-gcd (max m n) (min m n))))

(time (gcd-generative 101135853 45014640))
; cpu time: 0 real time: 0 gc time: 0
