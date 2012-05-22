;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.4.3) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
(define FUEL_PER_PIXEL 1)
(define fuel 100)
(define (drive delta picture)
  (local ((define fuel-consumption (* (abs delta) FUEL_PER_PIXEL)))
    (cond [(>= fuel fuel-consumption)
           (begin
             (set! fuel (- fuel fuel-consumption))
             ;(display fuel) (newline)
             (move-picture delta picture))]
          [else (error 'drive "Not enough fuel")])))


(define-struct circle (center radius color))
(define-struct rectangle (nw width height color))

(define (draw-a-circle circle)
  (draw-circle (circle-center circle)
               (circle-radius circle)
               (circle-color circle)))
(define (draw-a-rectangle rectangle)
  (draw-solid-rect (rectangle-nw rectangle)
                   (rectangle-width rectangle)
                   (rectangle-height rectangle)
                   (rectangle-color rectangle)))
(define (clear-a-circle circle)
  (clear-circle (circle-center circle)
               (circle-radius circle)
               (circle-color circle)))
(define (clear-a-rectangle rectangle)
  (clear-solid-rect (rectangle-nw rectangle)
                   (rectangle-width rectangle)
                   (rectangle-height rectangle)
                   (rectangle-color rectangle)))

(define (draw-shape shape)
  (cond [(circle? shape) (draw-a-circle shape)]
        [(rectangle? shape) (draw-a-rectangle shape)]
        [else "draw-shape: non-shape"]))
(define (clear-shape shape)
  (cond [(circle? shape) (clear-a-circle shape)]
        [(rectangle? shape) (clear-a-rectangle shape)]
        [else "clear-shape: non-shape"]))
(define (move-shape delta shape)
  (cond [(circle? shape)
         (make-circle (make-posn (+ delta (posn-x (circle-center shape)))
                                 (posn-y (circle-center shape)))
                      (circle-radius shape)
                      (circle-color shape))]
        [(rectangle? shape)
         (make-rectangle (make-posn (+ delta (posn-x (rectangle-nw shape)))
                                    (posn-y (rectangle-nw shape)))
                         (rectangle-width shape)
                         (rectangle-height shape)
                         (rectangle-color shape))]
        [else "move-shape: non-shape"]))

(define (draw-losh losh)
  (cond [(empty? losh) true]
        [else (and (draw-shape (first losh))
                   (draw-losh (rest losh)))]))
(define (clear-losh losh)
  (cond [(empty? losh) true]
        [else (and (clear-shape (first losh))
                   (clear-losh (rest losh)))]))

(define (draw-and-clear-picture picture)
  (and (draw-losh picture)
       ;(sleep-for-a-while 1)
       (clear-losh picture)))

(define (_move-picture delta picture)
  (cond [(empty? picture) empty]
        [else (cons (move-shape delta (first picture)) (_move-picture delta (rest picture)))]))
(define (move-picture delta picture)
  (cond [(draw-and-clear-picture picture) (_move-picture delta picture)]
        [else false]))

(start 500 100)

(define FACE
  (list (make-circle (make-posn 50 50) 40 'red)
        (make-rectangle (make-posn 30 20) 5 5 'blue)
        (make-rectangle (make-posn 60 20) 5 5 'blue)
        (make-rectangle (make-posn 40 75) 20 10 'red)
        (make-rectangle (make-posn 45 355) 10 30 'blue)))

(draw-losh
 (drive -5
  (drive 23
   (drive 10 FACE))))