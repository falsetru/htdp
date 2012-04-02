(define (p1 a y) 
  (+ (* a y)
     (+ (* 2 a)
	(+ (* 2 y) 22))))

(define (p2 x)
  (+ (* 55 x) (+ x 11)))

(define (p3 b)
  (+ (p1 b 0)
     (+ (p1 b 1) (p2 b))))
