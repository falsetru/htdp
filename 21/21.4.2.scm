(define-struct rectangle (nw width height color))

(define (process-rectangle f rect)
  (f (rectangle-nw rect)
     (rectangle-width rect)
     (rectangle-height rect)
     (rectangle-color rect)))

(define (draw-a-rectangle rect) (process-rectangle draw-solid-rect rect))
(define (clear-a-rectangle rect) (process-rectangle clear-solid-rect rect))
(define (translate-rectangle rect delta)
  (local ((define (move nw width height color)
            (make-rectangle (make-posn (+ (posn-x nw) delta)
                                       (posn-y nw))
                            width
                            height
                            color)))
         (process-rectangle move rect)))

; test
(start 300 300)
(define r (make-rectangle (make-posn 100 100) 50 50 'black))
(draw-a-rectangle (translate-rectangle r 50))
;(clear-a-rectangle (translate-rectangle r 50))
