#lang racket

(define (make-hangman WORDS)
  (local ((define PARTS '(head body right-arm left-arm right-leg left-leg))

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
            (set-word (list-ref WORDS (random (length WORDS)))))

          (define (make-status-word word)
            (map (lambda (c) '_) word))

          (define (set-word i)
            (begin
              (set! chosen-word (list-ref WORDS i))
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



          (define (service-manager msg)
            (cond [(symbol=? msg 'guess) hangman-guess]
                  [(symbol=? msg 'set-word) set-word] ; for test
                  [error (error 'make-hangman "message not understood")]))
          )

         service-manager))


(require rackunit)
(require rackunit/text-ui)

(define make-hangman-tests
  (test-suite
   "Test for make-hangman"

   (test-case
    ""
    (define easy
      (make-hangman
        (map (lambda (w) (map (lambda (x) (string->symbol (string x))) (string->list (symbol->string w))))
             (list 'a 'an 'and 'able 'adler))))
    (define difficult
      (make-hangman
        (map (lambda (w) (map (lambda (x) (string->symbol (string x))) (string->list (symbol->string w))))
             (list 'ardvark 'schemer))))

    (define hangman-easy (easy 'guess))
    (define hangman-difficult (difficult 'guess))
    ((easy 'set-word) 0)
    ((difficult 'set-word) 1)

    (check-equal? (hangman-easy 'a) "You won")
    (check-equal? (hangman-difficult 'a) (list "Sorry" 'head '(_ _ _ _ _ _ _)))
    )
   ))

(exit (run-tests make-hangman-tests))
