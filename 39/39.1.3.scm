;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 39.1.3) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
;; the positions of the bulbs
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))

(define WIDTH 50)
(define RADIUS 20)
(define DISTANCE-BETWEEN-BULBS 10)
(define HEIGHT 
  (+ DISTANCE-BETWEEN-BULBS
     (* 2 RADIUS)
     DISTANCE-BETWEEN-BULBS
     (* 2 RADIUS)
     DISTANCE-BETWEEN-BULBS
     (* 2 RADIUS)
     DISTANCE-BETWEEN-BULBS))




(define (clear-bulb x color)
  (cond [(symbol=? color 'red)
         (and
          (clear-solid-disk (make-posn x Y-RED) BULB-RADIUS 'red)
          (draw-circle (make-posn x Y-RED) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and
          (clear-solid-disk (make-posn x Y-YELLOW) BULB-RADIUS 'yellow)
          (draw-circle (make-posn x Y-YELLOW) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and
          (clear-solid-disk (make-posn x Y-GREEN) BULB-RADIUS 'green)
          (draw-circle (make-posn x Y-GREEN) BULB-RADIUS 'green))]))

(define (draw-bulb x color)
  (cond [(symbol=? color 'red)
         (and
          (clear-circle (make-posn x Y-RED) BULB-RADIUS 'red)
          (draw-solid-disk (make-posn x Y-RED) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and
          (clear-circle (make-posn x Y-YELLOW) BULB-RADIUS 'yellow)
          (draw-solid-disk (make-posn x Y-YELLOW) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and
          (clear-circle (make-posn x Y-GREEN) BULB-RADIUS 'green)
          (draw-solid-disk (make-posn x Y-GREEN) BULB-RADIUS 'green))]))



;; View:
;; draw-light : TL-color number  ->  true
;; to (re)draw the traffic light on the canvas 
(define (draw-light current-color x-posn)
  (local ((define left-border-x (- x-posn (/ WIDTH 2)))
          (define right-border-x (+ left-border-x WIDTH)))
    (begin
      (clear-solid-line (make-posn left-border-x 0)
                        (make-posn left-border-x HEIGHT))
      (clear-solid-line (make-posn right-border-x 0)
                        (make-posn right-border-x HEIGHT))
      (draw-solid-line (make-posn left-border-x 0)
                       (make-posn left-border-x HEIGHT))
      (draw-solid-line (make-posn right-border-x 0)
                       (make-posn right-border-x HEIGHT))
      (for-each
       (lambda (c)
         (if (symbol=? c current-color)
             (begin (clear-bulb x-posn c) (draw-bulb x-posn c))
             (begin (draw-bulb x-posn c) (clear-bulb x-posn c))))
      '(red green yellow))
      
      true)
    ))

;; Model:
;; make-traffic-light : symbol number  ->  ( ->  true)
;; to create a red light with (make-posn x-posn 0) as the upper-left corner
;; effect: draw the traffic light on the canvas
(define (make-traffic-light street x-posn)
  (local (;; current-color : TL-color
          ;; to keep track of the current color of the traffic light
          (define current-color 'red)
	  
	  ;; init-traffic-light :  ->  true
	  ;; to (re)set current-color to red and to (re)create the view 
	  (define (init-traffic-light)
	    (begin
	      (set! current-color 'red)
	      (draw-light current-color x-posn)))
	  
          ;; next :  ->  true
          ;; effect: to change current-color from 'green to 'yellow, 
          ;; 'yellow to 'red, and 'red to 'green
          (define (next)
            (begin
              (set! current-color (next-color current-color))
              (draw-light current-color x-posn)))
	  
          ;; next-color : TL-color  ->  TL-color
          ;; to compute the successor of current-color based on the traffic laws
          (define (next-color current-color)
            (cond
              [(symbol=? 'green current-color) 'yellow]
              [(symbol=? 'yellow current-color) 'red]
              [(symbol=? 'red current-color) 'green])))
    (begin
      ;; Initialize and produce next
      (init-traffic-light)
      next)))



(start 300 300)
;; lights : (listof traffic-light)
;; to manage the lights along Sunrise 
(define lights
  (list (make-traffic-light 'sunrise@rice 50)
        (make-traffic-light 'sunrise@cmu 150)))

((second lights))
(andmap (lambda (a-light) (a-light)) lights)