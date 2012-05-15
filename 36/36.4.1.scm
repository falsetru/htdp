(define current-color 'red)

;; Definition:
(define (next)
  (cond
    [(symbol=? 'green current-color) (set! current-color 'yellow)]
    [(symbol=? 'yellow current-color) (set! current-color 'red)]
    [(symbol=? 'red current-color) (set! current-color 'green)]))
  

(define (init-traffic-light)
  (set! current-color 'red))

(define (clear-bulb color)
  (cond [(symbol=? color 'red)
         (and
          (clear-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
          (draw-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and
          (clear-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)
          (draw-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and
          (clear-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)
          (draw-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))

(define (draw-bulb color)
  (cond [(symbol=? color 'red)
         (and
          (clear-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
          (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and
          (clear-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)
          (draw-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and
          (clear-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)
          (draw-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))



;; dimensions of traffic light    
(define WIDTH 50)
(define HEIGHT 160)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)

;; the positions of the bulbs 
(define X-BULBS (quotient WIDTH 2))
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))

(define (draw-traffic-light)
  (begin
    (clear-bulb 'red)
    (clear-bulb 'yellow)
    (clear-bulb 'green)
    (draw-bulb current-color)))

;; draw the light with the red bulb turned on
(start WIDTH HEIGHT)

(define (go)
  (begin
   (draw-traffic-light)
   (next)
   (wait-for-mouse-click)
   (go)))
(go)
