(define (gcd-generative n m)
  (local ((define (clever-gcd larger smaller)
	    (cond
	      [(= smaller 0) larger]
	      [else (clever-gcd smaller (remainder larger smaller))])))
    (clever-gcd (max m n) (min m n))))

(time (gcd-generative 101135853 45014640))
; cpu time: 0 real time: 0 gc time: 0


; (gcd-generative 101135853 45014640) =
; (gcd-generative 45014640 11106573) =
; (gcd-generative 11106573 588348) =
; (gcd-generative 588348 516309) =
; (gcd-generative 516309 72039) =
; (gcd-generative 72039 12036) =
; (gcd-generative 12036 11859) =
; (gcd-generative 11859 117) =
; (gcd-generative 117 0) = 117
