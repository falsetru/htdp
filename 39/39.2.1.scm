;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 39.2.1) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
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

(define (redraw lights)
  (begin
    (clear-all)
    (map
     (lambda (light)
       (draw-light (second light)
                   (third light)))
     lights)))


(define (next-color current-color)
  (cond
    [(symbol=? 'green current-color) 'yellow]
    [(symbol=? 'yellow current-color) 'red]
    [(symbol=? 'red current-color) 'green]))


(define (make-city)
  (local ((define lights empty) ; (listof (name:symbol color:symbol x-posn:number))
          (define next-x 50)
          (define (add name)
            (begin
              (set! lights (cons (list name 'red next-x) lights))
              (set! next-x (+ next-x 100))
              (redraw lights)
              ))
          (define (remove name)
            (local ((define (removed name lights)
                      (cond [(empty? lights) empty]
                            [(symbol=? (first (first lights)) name) (rest lights)]
                            [else (cons (first lights) (removed name (rest lights)))])))
              (begin
                (set! lights (removed name lights))
                (redraw lights))))
          (define (changed name f lights)
            (cond
              [(empty? lights) empty]
              [(symbol=? (first (first lights)) name)
               (cons (f (first lights)) (rest lights))]
              [else
               (cons (first lights) (change name f (rest lights)))]
              ))
          (define (change name f)
            (begin
              (set! lights (changed name f lights))
              (redraw lights)))
          (define (next name)
            (change name
                    (lambda (light)
                      (list name
                            (next-color (second light))
                            (third light))))
            )
          (define (reset name)
            (change name
                    (lambda (light)
                      (list name
                            'red
                            (third light))))
            )
          (define (service-manager msg)
            (cond [(symbol=? msg 'add) add]
                  [(symbol=? msg 'remove) remove]
                  [(symbol=? msg 'next) next]
                  [(symbol=? msg 'reset) reset]
                  [else (error 'make-city "message not understood")])))
    service-manager))


(start 500 500)
(define city (make-city))

(define te-name (make-text "traffic-light-name"))
(create-window
 (list (list te-name)
       (list (make-button "add" 
                          (lambda (e)
                            (begin
                              ((city 'add) (string->symbol (text-contents te-name)))
                              true
                              )))
             (make-button "remove"
                          (lambda (e)
                            (begin
                              ((city 'remove) (string->symbol (text-contents te-name)))
                              true
                              )))
             (make-button "next"
                          (lambda (e)
                            (begin
                              ((city 'next) (string->symbol (text-contents te-name)))
                              true
                              )))
             (make-button "reset"
                          (lambda (e)
                            (begin
                              ((city 'reset) (string->symbol (text-contents te-name)))
                              true
                              )))
             )))


;((city 'add) 'seoul)
;((city 'next) 'seoul)
;((city 'reset) 'seoul)