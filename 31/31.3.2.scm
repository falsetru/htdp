(define (! n)
  (cond
    [(zero? n) 1]
    [else (* n (! (sub1 n)))]))

(define (!-acc n0)
  (local (;; accumulator is the product of all natural numbers in [n0, n)
	  (define (!-a n accumulator)
	    (cond
	      [(zero? n) accumulator]
	      [else (!-a (sub1 n) (* n accumulator))])))
    (!-a n0 1)))

(define (many n f)
  (cond [(zero? n) true]
        [(and (f)
              (many (sub1 n) f))]))

(display (time (many 1000000 (lambda () (! 20))))) (newline)
; cpu time: 888 real time: 887 gc time: 104
(display (time (many 1000000 (lambda () (!-acc 20))))) (newline)
; cpu time: 376 real time: 375 gc time: 168
