;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.2.6) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp")))))
(define (make-status-word word)
  (map (lambda (c) '_) word))

(define PARTS '(head body right-arm left-arm right-leg left-leg))
(define WORDS 
  '((h e l l o)
    (w o r l d)
    (i s)
    (a)
    (s t u p i d)
    (p r o g r a m)
    (a n d)
    (s h o u l d)
    (n e v e r)
    (b e)
    (u s e d)
    (o k a y)
    ))
(define WORDS# (length WORDS))
(define chosen-word (first WORDS))

;; status-word : word
;; represents which letters the player has and hasn't guessed
(define status-word (first WORDS))

;; body-parts-left : (listof body-part)
;; represents the list of body parts that are still "available"
(define body-parts-left PARTS)

(define used-letters empty)

;; hangman :  ->  void
;; effect: initialize chosen-word, status-word, and body-parts-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word (make-status-word chosen-word))
    (set! body-parts-left PARTS)
    (set! used-letters empty)))

;; hangman-guess : letter  ->  response
;; to determine whether the player has won, lost, or may continue to play
;; and, if so, which body part was lost, if no progress was made
;; effects: (1) if the guess represents progress, update status-word
;; (2) if not, shorten the body-parts-left by one 
(define (hangman-guess guess)
  (cond
    [(cons? (memq guess used-letters))
     (list "You have used this guess before")]
    [else
     (begin
       (set! used-letters (cons guess used-letters))
       (local ((define new-status (reveal-list chosen-word status-word guess)))
         (cond
           
           [(equal? new-status status-word)
            (local ((define next-part (first body-parts-left)))
              (begin 
                (set! body-parts-left (rest body-parts-left))
                (cond
                  [(empty? body-parts-left) (list "The End" chosen-word)]
                  [else (list "Sorry" next-part status-word)])))]
           [else
            (cond
              [(equal? new-status chosen-word) "You won"]
              [else 
               (begin 
                 (set! status-word new-status)
                 (list "Good guess!" status-word))])])))]))

;; reveal-list : word word letter  ->  word
;; to compute the new status word
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
	    (cond
	      [(symbol=? chosen-letter guess) guess]
	      [else status-letter])))
    (map reveal-one chosen-word status-word)))


(define (draw-next-part part) 
  (cond 
    ((symbol=? part 'left-leg) 
     (draw-solid-line (make-posn 100 300) (make-posn 180 380))) 
    ((symbol=? part 'right-leg) 
     (draw-solid-line (make-posn 100 300) (make-posn 20 380))) 
    ((symbol=? part 'left-arm) 
     (draw-solid-line (make-posn 100 150) (make-posn 180 230))) 
    ((symbol=? part 'right-arm) 
     (draw-solid-line (make-posn 100 150) (make-posn 20 230))) 
    ((symbol=? part 'body) 
     (draw-solid-line (make-posn 100 150) (make-posn 100 300))) 
    ((symbol=? part 'head) 
     (and (and (and (and (and
                          (draw-circle  (make-posn 100 100) 50 'red)
                          (draw-solid-line (make-posn 85 75) (make-posn 75 85)))
                         (draw-solid-line (make-posn 75 75) (make-posn 85 85)))
                    (draw-solid-line (make-posn 125 75) (make-posn 115 85)))
               (draw-solid-line (make-posn 125 85) (make-posn 115 75))) (draw-circle (make-posn 100 125) 10 'red))) 
    ((symbol=? part 'noose) 
     (and (draw-solid-line (make-posn 1 10) (make-posn 85 10)) (draw-solid-line (make-posn 85 10) (make-posn 85 50)))) 
    (else 'noSuchPart)))

(define (as-string word)
  (foldr string-append "" (map symbol->string word)))


(hangman)
(start 500 500)

(define msg (make-message ""))
(define status (make-message (as-string status-word)))



(define (draw-status)
  (draw-message status (as-string status-word)))


(create-window
 (list (map
        (lambda (c)
          (make-button
           (symbol->string c)
           (lambda (e)
             (begin
               (local ((define result (hangman-guess c)))
                 (begin
                   (draw-status)
                   (cond
                     [(equal? result "You won") (draw-message msg "You won")]
                     [(equal? (first result) "The End")
                      (begin
                        (draw-message msg (string-append "Game over: word was '"
                                                         (as-string chosen-word)
                                                         "'"))
                        (draw-next-part (first (reverse PARTS))))
                      ]
                     [(equal? (first result) "Sorry")
                      (begin
                        (draw-message msg "Sorry")
                        (draw-next-part (second result)))]
                     [else (draw-message msg (first result))])
                   )
                 )
               true))))
        '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
       (list msg)
       (list status)))
