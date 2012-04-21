;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.3) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
(define-struct triangle (a b c))

(define (sierpinski t)
  (cond
    [(too-small? t) true]
    [else 
      (local ((define a-b (mid-point (triangle-a t) (triangle-b t)))
	      (define b-c (mid-point (triangle-b t) (triangle-c t)))
	      (define c-a (mid-point (triangle-a t) (triangle-c t))))
	(and
	  (draw-triangle t)	    
	  (sierpinski (make-triangle (triangle-a t) a-b c-a))
	  (sierpinski (make-triangle (triangle-b t) a-b b-c))
	  (sierpinski (make-triangle (triangle-c t) c-a b-c))))]))

(define (mid-point a-posn b-posn)
  (make-posn
    (mid (posn-x a-posn) (posn-x b-posn))
    (mid (posn-y a-posn) (posn-y b-posn))))

(define (mid x y)
  (/ (+ x y) 2))


(define (draw-triangle t)
  (and (draw-solid-line (triangle-a t) (triangle-b t) 'black)
       (draw-solid-line (triangle-b t) (triangle-c t) 'black)
       (draw-solid-line (triangle-c t) (triangle-a t) 'black)))

(define (too-small? t)
  (< (+ (distance (triangle-a t) (triangle-b t))
        (distance (triangle-b t) (triangle-c t))
        (distance (triangle-c t) (triangle-a t)))
     20))

(define (distance a b)
  (sqrt (+ (sqr (- (posn-x a) (posn-x b)))
           (sqr (- (posn-y a) (posn-y b))))))


(define A (make-posn 200 0))
(define B (make-posn 27 300))
(define C (make-posn 373 300))
(define a-triangle (make-triangle A B C))
(start 600 600)
(sierpinski a-triangle)