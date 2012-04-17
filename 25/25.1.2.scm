;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 25.1.2) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; TeachPack: draw.ss 

(define-struct ball (x y delta-x delta-y))
;; A ball is a structure: 
;;   (make-ball number number number number)

;; draw-and-clear : a-ball  ->  true
;; draw, sleep, clear a disk from the canvas 
;; structural design, Scheme knowledge
(define (draw-and-clear-balls balls)
  (and
   (andmap (lambda (a-ball) (draw-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)) balls)
   (sleep-for-a-while DELAY)
   (andmap (lambda (a-ball) (clear-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)) balls)))

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
(define DELAY 0.1)

;; out-of-bounds? : a-ball  ->  boolean
;; to determine whether a-ball is outside of the bounds
;; domain knowledge, geometry
(define (out-of-bounds? a-ball)
  (not
   (and
     (<= 0 (ball-x a-ball) WIDTH)
     (<= 0 (ball-y a-ball) HEIGHT))))


; balls -> true
(define (move-balls balls)
  (cond [(empty? balls) true]
        [else (and (draw-and-clear-balls balls)
                   (move-balls (filter inside-bounds? (map move-ball balls))))]))

(define (inside-bounds? ball) (not (out-of-bounds? ball)))

(define balls (list (make-ball 10 20 -5 +17)
                    (make-ball 10 20 +20 0)
                    (make-ball 80 80 -20 -20)))

(start WIDTH HEIGHT)
(move-balls balls)
(stop)
