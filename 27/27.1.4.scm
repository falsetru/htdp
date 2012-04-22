;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.4) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
(define (forward point length rad)
  (make-posn
   (+ (posn-x point) (* length (cos rad)))
   (+ (posn-y point) (* length (sin rad)))))

(define (savannah point length rad)
  (cond [(< length 5) true]
        [else (and (draw-solid-line point (forward point length rad) 'black)
                   (savannah (forward point (/ (* 1 length) 3) rad) (/ length 2) (- rad (/ pi 8)))
                   (savannah (forward point (/ (* 2 length) 3) rad) (/ length 2) (+ rad (/ pi 8))))]))

(start 400 600)
(savannah (make-posn 200 500) 400 (* pi -1/2))
