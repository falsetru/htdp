(define-struct circle (center radius color))

(define (process-circle f circle)
  (f (circle-center circle)
     (circle-radius circle)
     (circle-color circle)))

(define (draw-a-circle circle) (process-circle draw-circle circle))
(define (clear-a-circle circle) (process-circle clear-circle circle))
(define (translate-circle circle delta)
  (local ((define (move center radius color)
            (make-circle (make-posn (+ (posn-x center) delta) (posn-y center))
                         radius
                         color)))
         (process-circle move circle)))

; test
(start 300 300)
(define c (make-circle (make-posn 100 100) 100 'black))
(draw-a-circle (translate-circle c 100))
