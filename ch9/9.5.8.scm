(define (draw-circles p lon)
  (cond [(empty? lon) true]
        [else (and (draw-circle p (first lon) 'black)
                   (draw-circles p (rest lon)))]))

;(start 400 400)
;(draw-circles (make-posn 160 160)
;              '(10 20 40 80 160))
