(define (next@rice)
  (begin
    (set! current-color@rice (next-color@rice current-color@rice))
    (draw-light current-color@rice 50)))

(define (next@cmu)
  (begin
    (set! current-color@cmu (next-color@cmu current-color@cmu))
    (draw-light current-color@cmu 150)))
