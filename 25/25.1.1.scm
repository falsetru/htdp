;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 25.1.1) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; TeachPack: draw.ss 

(define-struct ball (x y delta-x delta-y))
;; A ball is a structure: 
;;   (make-ball number number number number)

;; draw-and-clear : a-ball  ->  true
;; draw, sleep, clear a disk from the canvas 
;; structural design, Scheme knowledge
(define (draw-and-clear a-ball)
  (and
   (draw-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)
   (sleep-for-a-while DELAY)
   (clear-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)))

;; move-ball : ball  ->  ball
;; to create a new ball, modeling a move by a-ball
;; structural design, physics knowledge
(define (move-ball a-ball) 
  (make-ball (+ (ball-x a-ball) (ball-delta-x a-ball))
             (+ (ball-y a-ball) (ball-delta-y a-ball))
             (ball-delta-x a-ball)
             (ball-delta-y a-ball)))

;; Dimension of canvas 
(define WIDTH 100)
(define HEIGHT 100)
(define DELAY .1)

;; out-of-bounds? : a-ball  ->  boolean
;; to determine whether a-ball is outside of the bounds
;; domain knowledge, geometry
(define (out-of-bounds? a-ball)
  (not
   (and
     (<= 0 (ball-x a-ball) WIDTH)
     (<= 0 (ball-y a-ball) HEIGHT))))

;; move-until-out : a-ball  ->  true
;; to model the movement of a ball until it goes out of bounds
(define (move-until-out a-ball)
  (cond
    [(out-of-bounds? a-ball) true]
    [else (and (draw-and-clear a-ball)
               (move-until-out (move-ball a-ball)))]))

(start WIDTH HEIGHT)
(move-until-out (make-ball 10 20 0 0))
; 여기까지 안옴.
(stop)