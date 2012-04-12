(define N 10)

;; Model:
;; build-number : (listof digit)  ->  number
;; to translate a list of digits into a number
;; example: (build-number (list 1 2 3)) = 123
(define (build-number xs)
  (local ((define (build-number-helper digits acc)
            (cond [(empty? digits) acc]
                  [else (build-number-helper (rest digits) (+ (first digits) (* 10 acc)))])))
    (build-number-helper xs 0)))

(define target
  (local ((define (rand i) (random 10)))
    (build-number (build-list N rand))))



;; View:
;; the ten digits as strings 
(define DIGITS
  (build-list 10  number->string))

;; a list of three digit choice menus 
(define digit-choosers
  (local ((define (builder i) (make-choice DIGITS)))
    (build-list N builder)))

;; a message field for saying hello and displaying the number 
(define a-msg
  (make-message "Welcome"))

;; 



;; Controller: 
;; check-call-back : X  ->  true
;; to get the current choices of digits, convert them to a number, 
;; and to draw this number as a string into the message field 
(define (check-call-back b)
  (draw-message a-msg 
                (symbol->string
                 (check-guess
                  (build-number 
                   (map choice-index digit-choosers))
                  target))))

(define (check-guess guess target)
  (cond [(< guess target) 'TooSmall]
        [(> guess target) 'TooLarge]
        [else 'Perfect]))

(create-window 
 (list 
  (append digit-choosers (list a-msg))
  (list (make-button "Check Guess" check-call-back))))
