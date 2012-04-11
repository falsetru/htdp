(define-struct circle (center radius color))
(define-struct rectangle (nw width height color))

; circle
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

; rectangle
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

; shape
(define (process-shape f-circle f-rectangle shape)
  (cond [(circle? shape) (f-circle shape)]
        [(rectangle? shape) (f-rectangle shape)]
        [else "process-shape: non-shape"]))

(define (draw-shape shape)
  (process-shape draw-a-circle draw-a-rectangle shape))
(define (clear-shape shape)
  (process-shape clear-a-circle clear-a-rectangle shape))
(define (translate-shape shape delta)
  (local ((define (translate-circle-wrapper circle)
            (translate-circle circle delta))
          (define (translate-rectangle-wrapper rectangle)
            (translate-rectangle rectangle delta)))
  (process-shape translate-circle-wrapper translate-rectangle-wrapper shape)))

; losh
(define (draw-losh losh) (andmap draw-shape losh))
(define (clear-losh losh) (andmap clear-shape losh))
(define (translate-losh losh delta)
  (local ((define (move x)
            (translate-shape x delta)))
    (map move losh)))

; test
(start 300 300)
(define FACE
  (list (make-circle (make-posn 50 50) 40 'red)
        (make-rectangle (make-posn 30 20) 5 5 'blue)
        (make-rectangle (make-posn 60 20) 5 5 'blue)
        (make-rectangle (make-posn 40 75) 20 10 'red)
        (make-rectangle (make-posn 45 355) 10 30 'blue)))
(draw-losh (translate-losh FACE 100))
;(clear-losh (translate-losh FACE 100))
