(define (forward point length rad)
  (make-posn
   (+ (posn-x point) (* length (cos rad)))
   (+ (posn-y point) (* length (sin rad)))))

(define (short-enough? x) (< x 10))

(define (-^- p0 len rad)
  (local ((define p1 (forward p0 (* 1/3 len) rad))
          (define p2 (forward p0 (* 2/3 len) rad))
          (define p3 (forward p0 (* 3/3 len) rad))
          (define p1-p^-rad (+ rad (* 1/3 pi)))
          (define p^-p2-rad (- rad (* 1/3 pi)))
          (define p^ (forward p1 (* 1/3 len) p1-p^-rad))
          )
    (cond [(short-enough? len)
           (draw-solid-line p0 p3 'black)]
          [else
           (and
            (-^- p0 (* 1/3 len) rad)
            (-^- p2 (* 1/3 len) rad)
            (-^- p1 (* 1/3 len) p1-p^-rad)
            (-^- p^ (* 1/3 len) p^-p2-rad)
            )])))

(define (snow-flake p1 len)
  (local ((define p2 (forward p1 len (* 0/3 pi)))
          (define p3 (forward p2 len (* 4/3 pi))))
    (and
     (-^- p1 len (*  0/3 pi))
     (-^- p2 len (* -2/3 pi))
     (-^- p3 len (* +2/3 pi))
     )))


(start 300 300)
(snow-flake (make-posn 50 200) 200)
