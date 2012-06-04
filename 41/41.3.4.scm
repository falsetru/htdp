#lang racket

(define-struct hand (rank suit next) #:mutable #:transparent)

(define SPADES 's)
(define HEARTS 'h)
(define DIAMONDS 'd)
(define CLUBS 'c)

(define (create-hand r s)
  (make-hand r s empty))
(define (added-at-end rank suit a-hand)
  (cond
    [(empty? a-hand) (create-hand rank suit)]
    [else
      (make-hand
        (hand-rank a-hand)
        (hand-suit a-hand)
        (added-at-end rank suit (hand-next a-hand)))]))

(define (hands)
  (local
    ((define hand0 false)
     (define (service-manager msg)
       (cond [(symbol=? msg 'create-hand) (lambda (rank suit) (set! hand0 (create-hand rank suit)))]
             [(symbol=? msg 'add-at-end!) (lambda (rank suit) (set! hand0 (added-at-end rank suit hand0)))]
             [(symbol=? msg 'get-hand0) hand0] ; for test
             [else (error 'hands "unknow service")])))
    service-manager))

(require rackunit)
(require rackunit/text-ui)

(define last-card-tests
  (test-suite
   "Test for last-card"

   (test-case
    ""
    (define h (hands))
    ((h 'create-hand) 1 DIAMONDS)
    (check-equal?
      (h 'get-hand0)
      (make-hand 1 DIAMONDS empty))
    ((h 'add-at-end!) 2 CLUBS)
    (check-equal?
      (h 'get-hand0)
      (make-hand 1 DIAMONDS (make-hand 2 CLUBS empty)))
    ((h 'add-at-end!) 3 SPADES)
    (check-equal?
      (h 'get-hand0)
      (make-hand 1 DIAMONDS (make-hand 2 CLUBS (make-hand 3 SPADES empty))))
    )
   ))

(exit (run-tests last-card-tests))
