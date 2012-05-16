#lang racket

(define COLORS
  '(black white red blue green gold pink orange purple navy))
(define COL# (length COLORS))

(define target1 (first COLORS))
(define target2 (first COLORS))
(define guess-count 0)

(define (random-pick xs)
  (list-ref xs (random (length xs))))

(define (master)
  (begin (set! target1 (random-pick COLORS))
         (set! target2 (random-pick COLORS))
         (set! guess-count 0)))

(define (master-check guess1 guess2)
  (begin
    (set! guess-count (add1 guess-count))
    (list (check-color guess1 guess2 target1 target2) guess-count)))

(define (check-color guess1 guess2 target1 target2)
  (cond [(and (symbol=? guess1 target1 guess2 target2)) 'Perfect!]
        [(or (symbol=? guess1 target1 guess2 target2)) 'OneColorAtCorrectPosition]
        [(or (symbol=? guess1 target2 guess2 target1)) 'OneColorOccurs]
        [else 'NothingCorrect]))
