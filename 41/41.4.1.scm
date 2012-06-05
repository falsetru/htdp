;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 41.4.1) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp")))))

(define-struct circle (center radius))
(define-struct rectangle (nw width height))

(define (translate-circle circle delta-x)
  (begin
    (set-posn-x! (circle-center circle) (+ (posn-x (circle-center circle)) delta-x))
    ;(set-posn-y! (circle-center circle) (+ (posn-y (circle-center circle)) delta-y))
    circle))

(define (translate-rectangle rect delta-x)
  (begin
    (set-posn-x! (rectangle-nw rect) (+ (posn-x (rectangle-nw rect)) delta-x))
    ;(set-posn-y! (rectangle-nw rect) (+ (posn-y (rectangle-nw rect)) delta-y))
    rect))

(define (draw-a-circle a-circle)
  (draw-circle (circle-center a-circle) (circle-radius a-circle) 'black))
(define (clear-a-circle a-circle)
  (clear-circle (circle-center a-circle) (circle-radius a-circle) 'black))
(define (draw-and-clear-circle a-circle)
  (and
   (draw-a-circle a-circle)
   (sleep-for-a-while 1)
   (clear-a-circle a-circle)))

(define (move-circle delta a-circle)
  (cond
    [(draw-and-clear-circle a-circle) (translate-circle a-circle delta)]
    [else a-circle]))



(start 200 100)

(draw-a-circle 
  (move-circle 10
    (move-circle 10
      (move-circle 10
	(move-circle 10 (make-circle (make-posn 10 10) 10))))))