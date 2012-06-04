#lang racket

(require "41.3.1.scm")

(define (last-card hand)
  (cond [(empty? (hand-next hand))
         (list (hand-rank hand)
               (hand-suit hand))]
        [else (last-card (hand-next hand))]))

(require rackunit)
(require rackunit/text-ui)

(define last-card-tests
  (test-suite
   "Test for last-card"

   (test-case
    ""
    (define hand0 (create-hand 1 DIAMONDS))
    (check-equal? (last-card hand0) (list 1 DIAMONDS))
    (add-at-end! 2 CLUBS hand0)
    (check-equal? (last-card hand0) (list 2 CLUBS))
    )
   ))

(exit (run-tests last-card-tests))
