;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(define CENTER (make-posn 200 200))
(define RADIUS 200)

(define (circle-pt factor)
  (local ((define x-center (posn-x CENTER))
          (define y-center (posn-y CENTER))
          (define x 0)
          (define y 1)
          (define rad (* 2 pi factor)))
    (make-posn
     (+ x-center
        (* RADIUS (- (* x (cos rad)) (* y (sin rad)))))
     (- y-center 
        (* RADIUS (+ (* x (sin rad)) (* y (cos rad))))))))

(circle-pt 0); 200, 0
(circle-pt 1/3) ; -> 27, 300
(circle-pt 2/3) ; -> 373, 300