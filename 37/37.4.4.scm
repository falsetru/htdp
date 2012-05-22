;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.4.4) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
(define TL1 'green)
(define TL2 'red)

;; Definition:
(define (next)
  (cond
    [(symbol=? TL1 'green)  (begin (set! TL1 'yellow))]
    [(symbol=? TL1 'yellow) (begin (set! TL1 'red) (set! TL2 'green))]
    [(symbol=? TL2 'green)  (begin (set! TL2 'yellow))]
    [(symbol=? TL2 'yellow) (begin (set! TL2 'red) (set! TL1 'green))]
    ))

(define (init-traffic-light)
  (begin
    (set! TL1 'green)
    (set! TL2 'red)))

(define (clear-bulb color)
  (cond [(symbol=? color 'red)
         (and (clear-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
              (draw-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and (clear-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)
              (draw-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and (clear-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)
              (draw-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))

(define (draw-bulb color)
  (cond [(symbol=? color 'red)
         (and (clear-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
              (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and (clear-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)
              (draw-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and (clear-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)
              (draw-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))

(define (clear-bulb-2 color)
  (cond [(symbol=? color 'red)
         (and (clear-solid-disk (make-posn X-RED Y-BULBS) BULB-RADIUS 'red)
              (draw-circle (make-posn X-RED Y-BULBS) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and (clear-solid-disk (make-posn X-YELLOW Y-BULBS) BULB-RADIUS 'yellow)
              (draw-circle (make-posn X-YELLOW Y-BULBS) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and (clear-solid-disk (make-posn X-GREEN Y-BULBS) BULB-RADIUS 'green)
              (draw-circle (make-posn X-GREEN Y-BULBS) BULB-RADIUS 'green))]))

(define (draw-bulb-2 color)
  (cond [(symbol=? color 'red)
         (and (clear-circle (make-posn X-RED Y-BULBS) BULB-RADIUS 'red)
              (draw-solid-disk (make-posn X-RED Y-BULBS) BULB-RADIUS 'red))]
        [(symbol=? color 'yellow)
         (and (clear-circle (make-posn X-YELLOW Y-BULBS) BULB-RADIUS 'yellow)
              (draw-solid-disk (make-posn X-YELLOW Y-BULBS) BULB-RADIUS 'yellow))]
        [(symbol=? color 'green)
         (and (clear-circle (make-posn X-GREEN Y-BULBS) BULB-RADIUS 'green)
              (draw-solid-disk (make-posn X-GREEN Y-BULBS) BULB-RADIUS 'green))]))

;; dimensions of traffic light    
(define WIDTH 200)
(define HEIGHT 200)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)

;; the positions of the bulbs 
(define X-BULBS 25)
(define Y-RED    (+ BULB-DISTANCE (* 3 BULB-RADIUS)))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN  (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))

(define Y-BULBS 25)
(define X-RED    (+ BULB-DISTANCE (* 3 BULB-RADIUS)))
(define X-YELLOW (+ X-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define X-GREEN  (+ X-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))


(define (draw-traffic-light)
  (begin
    (clear-bulb 'red)
    (clear-bulb 'yellow)
    (clear-bulb 'green)
    (draw-bulb TL1)
    (clear-bulb-2 'red)
    (clear-bulb-2 'yellow)
    (clear-bulb-2 'green)
    (draw-bulb-2 TL2)))

;; draw the light with the red bulb turned on
(start WIDTH HEIGHT)

(define (go)
  (begin
   (draw-traffic-light)
   (next)
   (wait-for-mouse-click)
   (go)))
(go)