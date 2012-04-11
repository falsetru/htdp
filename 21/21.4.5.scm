(define-struct line (start end color))
(define-struct circle (center radius color))
(define-struct rectangle (nw width height color))

; line
(define (process-line f line)
  (f (line-start line)
     (line-end line)
     (line-color line)))
(define (draw-a-line line) (process-line draw-solid-line line))
(define (clear-a-line line) (process-line clear-solid-line line))
(define (translate-line line delta-x delta-y)
  (local ((define (move start end color)
            (make-line (make-posn (+ (posn-x start) delta-x) (+ (posn-y start) delta-y))
                       (make-posn (+ (posn-x end) delta-x) (+ (posn-y end) delta-y))
                       color)))
    (process-line move line)))

; circle
(define (process-circle f circle)
  (f (circle-center circle)
     (circle-radius circle)
     (circle-color circle)))

(define (draw-a-circle circle) (process-circle draw-circle circle))
(define (clear-a-circle circle) (process-circle clear-circle circle))
(define (translate-circle circle delta-x delta-y)
  (local ((define (move center radius color)
            (make-circle (make-posn (+ (posn-x center) delta-x)
                                    (+ (posn-y center) delta-y))
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
(define (translate-rectangle rect delta-x delta-y)
  (local ((define (move nw width height color)
            (make-rectangle (make-posn (+ (posn-x nw) delta-x)
                                       (+ (posn-y nw) delta-y))
                            width
                            height
                            color)))
         (process-rectangle move rect)))

; shape
(define (process-shape f-line f-circle f-rectangle shape)
  (cond [(line? shape) (f-line shape)]
        [(circle? shape) (f-circle shape)]
        [(rectangle? shape) (f-rectangle shape)]
        [else (error "process-shape: ``non-shape" shape)]))

(define (draw-shape shape)
  (process-shape draw-a-line
                 draw-a-circle
                 draw-a-rectangle
                 shape))
(define (clear-shape shape)
  (process-shape clear-a-line
                 clear-a-circle
                 clear-a-rectangle
                 shape))
(define (translate-shape shape delta-x delta-y)
  (local ((define (translate-line-wrapper shape)      (translate-line shape delta-x delta-y))
          (define (translate-circle-wrapper shape)    (translate-circle shape delta-x delta-y))
          (define (translate-rectangle-wrapper shape) (translate-rectangle shape delta-x delta-y)))
    (process-shape translate-line-wrapper
                   translate-circle-wrapper
                   translate-rectangle-wrapper
                   shape)))

; losh
(define (draw-losh losh) (andmap draw-shape losh))
(define (clear-losh losh) (andmap clear-shape losh))
(define (translate-losh losh delta-x delta-y)
  (local ((define (move x)
            (translate-shape x delta-x delta-y)))
    (map move losh)))

(define (move-lander-left-right delta lander)
  (cond [(clear-losh lander) (translate-losh lander delta 0)]
        [else lander]))

(define (move-lander-up-down delta lander)
  (cond [(clear-losh lander) (translate-losh lander 0 delta)]
        [else lander]))

; test

; LUNAR 정의하기에는 잉여력이 부족; FACE에 더듬이 부착하는걸로 대체
(define LUNAR
  (list (make-line (make-posn 20 22) (make-posn 10 0) 'black)
        (make-line (make-posn 80 22) (make-posn 90 0) 'black)
        (make-circle (make-posn 50 50) 40 'red)
        (make-rectangle (make-posn 30 20) 5 5 'blue)
        (make-rectangle (make-posn 60 20) 5 5 'blue)
        (make-rectangle (make-posn 40 75) 20 10 'red)
        (make-rectangle (make-posn 45 35) 10 30 'blue)))

(start 500 500)
(draw-losh LUNAR)
(control LUNAR 10 move-lander-left-right move-lander-up-down draw-losh)
