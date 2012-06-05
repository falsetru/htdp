#lang racket

;; create-hand : rank suit  ->  hand
;; to create a hand from the rank and suit of a single card
(define (create-hand rank suit)
  (local ((define-struct hand (rank suit next) #:mutable)
	  
          (define the-hand (make-hand rank suit empty))
	  
          ;; insert-aux! : rank suit hand  ->  void
          ;; assume: hand is sorted by rank in descending order
          ;; effect: to add a card with r as rank and s as suit
          ;; at the proper place
          (define (insert-aux! r s a-hand)
            (cond
              [(empty? (hand-next a-hand)) 
               (set-hand-next! a-hand (make-hand r s empty))]
              [else (cond
                      [(>= (hand-rank a-hand)
			   r
			   (hand-rank (hand-next a-hand)))
                       (set-hand-next! a-hand
			 (make-hand r s (hand-next a-hand)))]
                      [else (insert-aux! r s (hand-next a-hand))])]))

          (define (delete-aux! r predecessor-of:a-hand a-hand)
            (cond
              [(empty? a-hand) (void)]
              [(= r (hand-rank a-hand))
               (set-hand-next! predecessor-of:a-hand (hand-next a-hand))]
              [else (delete-aux! r a-hand (hand-next a-hand))]))

          (define (dump-aux a-hand)
            (cond
              [(empty? a-hand) empty]
              [else (cons (list (hand-rank a-hand) (hand-suit a-hand))
                          (dump-aux (hand-next a-hand)))]))

          (define (hands->list a-hand)
            (cond [(empty? a-hand) empty]
                  [else (cons a-hand (hands->list (hand-next a-hand)))]))

          (define (service-manager msg)
            (cond
              [(symbol=? msg 'dump) (dump-aux the-hand)] ; for test
              [(symbol=? msg 'insert!) 
               (lambda (r s)
                 (cond
                   [(empty? the-hand) (set! the-hand (make-hand r s empty))]
                   [(> r (hand-rank the-hand)) (set! the-hand (make-hand r s the-hand))]
                   [else (insert-aux! r s the-hand)]))]
              [(symbol=? msg 'delete!)
               (lambda (r)
                 (cond
                   [(empty? the-hand) (void)]
                   [(= r (hand-rank the-hand)) (set! the-hand (hand-next the-hand))]
                   [else (delete-aux! r the-hand (hand-next the-hand))]))]
              [(symbol=? msg 'suits)
               (lambda (r)
                 (map
                   (lambda (h) (hand-suit h))
                   (filter
                     (lambda (h) (= (hand-rank h) r))
                     (hands->list the-hand))))]
              [else (error 'managed-hand "message not understood")])))
    service-manager))

(require rackunit)
(require rackunit/text-ui)

(define create-hand-tests
  (test-suite
   "Test for foo"

   (test-case
    "insert! delete!"
    (define h (create-hand 1 'S))
    ((h 'insert!) 3 'S)
    ((h 'insert!) 4 'S)
    ((h 'insert!) 2 'S)
    ((h 'insert!) 9 'S)
    (check-equal? (h 'dump) '((9 S) (4 S) (3 S) (2 S) (1 S)))

    ((h 'delete!) 9)
    (check-equal? (h 'dump) '((4 S) (3 S) (2 S) (1 S)))
    ((h 'delete!) 1)
    (check-equal? (h 'dump) '((4 S) (3 S) (2 S)))
    ((h 'delete!) 1)
    (check-equal? (h 'dump) '((4 S) (3 S) (2 S)))
    ((h 'delete!) 3)
    (check-equal? (h 'dump) '((4 S) (2 S)))
    ((h 'delete!) 2)
    (check-equal? (h 'dump) '((4 S)))
    ((h 'delete!) 4)
    (check-equal? (h 'dump) '())
    )

   (test-case
    "suits"
    (define h (create-hand 1 'S))
    ((h 'insert!) 3 'S)
    ((h 'insert!) 4 'S)
    ((h 'insert!) 4 'D)
    ((h 'insert!) 2 'S)
    ((h 'insert!) 9 'S)
    (check-equal? ((h 'suits) 4) '(S D))
    (check-equal? ((h 'suits) 2) '(S))
    (check-equal? ((h 'suits) 11) '())
    )
   ))

(exit (run-tests create-hand-tests))
