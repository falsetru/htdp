(define (forward point length rad)
  (make-posn
   (+ (posn-x point) (* length (cos rad)))
   (+ (posn-y point) (* length (sin rad)))))

(define (short-enough? x) (< x 2))

(define (branch p0 len rad)
  (local ((define p1 (forward p0 (* 3/5 len) rad))
          (define p2 (forward p0 (* 2/2 len) rad))
          (define r1 (+ rad (* 1/3 pi)))
          (define r2 (- rad (* 1/3 pi)))
          )
    (and
     (draw-solid-line p0 p2 'black)
     (cond [(short-enough? len) true]
           [else
            (and
             (branch p1 (* 1/3 len) r1)
             (branch p1 (* 1/3 len) r2)
             )]))))

(define (snow-flake p1 len)
    (and
     (branch p1 len (*  0/3 pi))
     (branch p1 len (*  1/3 pi))
     (branch p1 len (*  2/3 pi))
     (branch p1 len (*  3/3 pi))
     (branch p1 len (*  4/3 pi))
     (branch p1 len (*  5/3 pi))
     true
     ))


(start 300 300)
(snow-flake (make-posn 150 150) 100)
