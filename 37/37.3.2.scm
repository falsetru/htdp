#lang racket

(require "37.2.1.scm")

;; Data Analysis and Definitions:

;; A letter is a symbol in: 'a ... 'z plus '_

;; A word is a (listof letter).

;; A body-part is one of the following symbols:
(define PARTS '(head body right-arm left-arm right-leg left-leg))

;; Constants:
;; some guessing words: 
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

;; the number of words we can choose from 
(define WORDS# (length WORDS))

;; chosen-word : word
;; the word that the player is to guess
(define chosen-word (first WORDS))

;; status-word : word
;; represents which letters the player has and hasn't guessed
(define status-word (first WORDS))

;; body-parts-left : (listof body-part)
;; represents the list of body parts that are still "available"
(define body-parts-left PARTS)

(define new-knowledge false)

;; hangman :  ->  void
;; effect: initialize chosen-word, status-word, and body-parts-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word (make-status-word chosen-word))
    (set! body-parts-left PARTS)
    (set! new-knowledge false)))

;; hangman-guess : letter  ->  response
;; to determine whether the player has won, lost, or may continue to play
;; and, if so, which body part was lost, if no progress was made
;; effects: (1) if the guess represents progress, update status-word
;; (2) if not, shorten the body-parts-left by one 
(define (hangman-guess guess)
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
            (list "Good guess!" status-word))])])))

;; reveal-list : word word letter  ->  word
;; to compute the new status word
;; effect: to set new-knowledge to true if guess reveals new knowledge
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
	    (cond
	      [(and (symbol=? chosen-letter guess)
		    (symbol=? status-letter '_))
	       (begin
		 (set! new-knowledge true)
		 guess)]
	      [else status-letter])))
    (begin
      (set! new-knowledge false)
      (map reveal-one chosen-word status-word))))


(require rackunit)
(require rackunit/text-ui)

(set! chosen-word '(b a l l))

(define hangman-new-knowledge-tests
  (test-suite
   "Test for hangman-new-knowledge"

   (test-case
    "1."
    (set! status-word '(b _ l l))
    (check-equal? (reveal-list chosen-word status-word 'a) '(b a l l))
    (check-equal? new-knowledge true)
    )

   (test-case
    "2."
    (set! status-word '(b _ _ _))
    (check-equal? (reveal-list chosen-word status-word 'x) '(b _ _ _))
    (check-equal? new-knowledge false)
    )

   (test-case
    "3."
    (set! status-word '(b _ _ _))
    (check-equal? (reveal-list chosen-word status-word 'l) '(b _ l l))
    (check-equal? new-knowledge true)
    )

   (test-case
    "4."
    (set! status-word '(b _ l l))
    (check-equal? (reveal-list chosen-word status-word 'l) '(b _ l l))
    (check-equal? new-knowledge false)
    )
   ))

(exit (run-tests hangman-new-knowledge-tests))
