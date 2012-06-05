#lang racket

;; create-hand : rank suit  ->  hand
;; to create a hand from the rank and suit of a single card
(define (create-hand rank suit)
  (local ((define-struct hand (rank suit next) #:mutable)
	  
          (define the-hand (make-hand rank suit empty))
	  
          (define (inserted r s a-hand)
            (cond [(empty? a-hand) (make-hand r s empty)]
                  [(>= r (hand-rank a-hand)) (make-hand r s a-hand)]
                  [else (make-hand
                          (hand-rank a-hand)
                          (hand-suit a-hand)
                          (inserted r s (hand-next a-hand)))]))

          (define (dump-aux a-hand)
            (cond
              [(empty? a-hand) empty]
              [else (cons (list (hand-rank a-hand) (hand-suit a-hand))
                          (dump-aux (hand-next a-hand)))]))

          (define (service-manager msg)
            (cond
              [(symbol=? msg 'dump) (dump-aux the-hand)] ; for test
              [(symbol=? msg 'insert!) 
               (lambda (r s)
                 (set! the-hand (inserted r s the-hand)))]
              [else (error 'managed-hand "message not understood")])))
    service-manager))

(require rackunit)
(require rackunit/text-ui)

(define create-hand-tests
  (test-suite
   "Test for foo"

   (test-case
    ""
    (define h (create-hand 1 'S))
    ((h 'insert!) 3 'S)
    ((h 'insert!) 4 'S)
    ((h 'insert!) 2 'S)
    ((h 'insert!) 9 'S)
    (check-equal? (h 'dump) '((9 S) (4 S) (3 S) (2 S) (1 S)))
    )
   ))

(exit (run-tests create-hand-tests))
