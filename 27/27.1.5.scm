(define (too-small? a b c)
  (< (+ (distance a b)
        (distance b c)
        (distance c a))
     5))

(define (distance a b)
  (sqrt (+ (sqr (- (posn-x a) (posn-x b)))
           (sqr (- (posn-y a) (posn-y b))))))


(define (draw-polygon a b c)
  (and (draw-solid-line a b 'black)
       (draw-solid-line b c 'black)))


(define (mid-point a-posn b-posn)
  (make-posn
    (mid (posn-x a-posn) (posn-x b-posn))
    (mid (posn-y a-posn) (posn-y b-posn))))

(define (mid x y)
  (/ (+ x y) 2))

(define (bezier p1 p2 p3)
  (cond [(too-small? p1 p2 p3) (draw-polygon p1 p2 p3)]
        [else
          (local ((define r2 (mid-point p1 p2))
                  (define q2 (mid-point p2 p3))
                  (define m  (mid-point r2 q2)))
                 (and (bezier p1 r2 m)
                      (bezier m q2 p3)))]))

(define p1 (make-posn 50 50))
(define p2 (make-posn 150 150))
(define p3 (make-posn 250 100))

(start 300 300)
(bezier p1 p2 p3)
