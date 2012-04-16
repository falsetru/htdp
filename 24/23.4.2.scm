(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define R 1000)
(define (integrate f a b)
  (local ((define W (/ (- b a) R))
          (define S (/ W 2))
          (define (Xi i) (+ a S (* i W)))
          (define (area-of-rectangle i) (* W (f (Xi i)))))
         (series R area-of-rectangle)))

(display (integrate sin 0 pi))
; R=10   -> 1.9591030712941107
; R=100  -> 1.9995887891442437
; R=1000 -> 1.9999958876670982
