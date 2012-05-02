(define (sum alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum (rest alon)))]))


(define (sum-acc alon0)
  (local ((define (sum-a alon accumulator)
	    (cond
	      [(empty? alon) accumulator]
	      [else (sum-a (rest alon) (+ (first alon) accumulator))])))
    (sum-a alon0 0)))


(define (g-series n)
  (cond
    [(zero? n) empty]
    [else (cons (expt -0.99 n) (g-series (sub1 n)))]))

(display (sum     (g-series #i1000))) (newline) ; -0.49746596003269394
(display (sum-acc (g-series #i1000))) (newline) ; -0.4974659600326953

(display (* 10e15 (sum     (g-series #i1000)))) (newline) ; -4974659600326939.0
(display (* 10e15 (sum-acc (g-series #i1000)))) (newline) ; -4974659600326953.0
