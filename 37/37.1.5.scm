;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.1.5) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp")))))
(define COLORS
  '(black white red blue green gold pink orange purple navy))
(define COL# (length COLORS))

(define target1 (first COLORS))
(define target2 (first COLORS))
(define guess1 (first COLORS))
(define guess2 (first COLORS))

(define guess-count 0)

(define (random-pick xs)
  (list-ref xs (random (length xs))))

(define (master)
  (begin (set! target1 (random-pick COLORS))
         (set! target2 (random-pick COLORS))
         (set! guess-count 0)))

(define (check-color guess1 guess2 target1 target2)
  (cond [(and (symbol=? guess1 target1) (symbol=? guess2 target2)) 'Perfect!]
        [(or (symbol=? guess1 target1) (symbol=? guess2 target2)) 'OneColorAtCorrectPosition]
        [(or (symbol=? guess1 target2) (symbol=? guess2 target1)) 'OneColorOccurs]
        [else 'NothingCorrect]))

(define (master-check)
  (local ((define result (check-color guess1 guess2 target1 target2)))
    (begin
      (if (symbol=? result 'Perfect)
          (master)
          (void))
      result))
  )

(define color-buttons
  (map (lambda (c)
         (make-button
          (symbol->string c)
          (lambda (e) 
            (begin
              (set! guess-count (add1 guess-count))
              (if (= (remainder guess-count 2) 1)
                  (begin
                    (set! guess1 c)
                    (draw-message (first choice-texts) (symbol->string c))
                    (draw-message result "Select another color"))
                  (begin
                    (set! guess2 c)
                    (draw-message (second choice-texts) (symbol->string c))
                    (draw-message result (symbol->string (master-check)))
                    ))
              true))))
       COLORS))

(define choice-texts
  (list (make-message "UNSELECTED")
        (make-message "UNSELECTED")))
(define result (make-message ""))

(create-window
 (list color-buttons
       choice-texts
       (list result)))