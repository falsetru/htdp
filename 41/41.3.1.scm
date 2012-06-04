#lang racket

(define-struct hand (rank suit next) #:mutable #:transparent)
(define SPADES 's)
(define HEARTS 'h)
(define DIAMONDS 'd)
(define CLUBS 'c)

(define (create-hand r s)
  (make-hand r s empty))
(define (add-at-end! rank suit a-hand)
  (cond
    [(empty? (hand-next a-hand))
     (set-hand-next! a-hand  (make-hand rank suit empty))]
    [else (add-at-end! rank suit (hand-next a-hand))]))

(require rackunit)
(require rackunit/text-ui)

(define add-to-end!-tests
  (test-suite
   "Test for add-to-end!"

   (test-case
     ""
     (define hand0 (create-hand 13 SPADES))
     (check-equal?
       (begin
         (add-at-end! 1 DIAMONDS hand0)
         (add-at-end! 2 CLUBS hand0)
         hand0)
       (make-hand 13 SPADES
                  (make-hand 1 DIAMONDS
                             (make-hand 2 CLUBS empty))))
     )
   ))

(exit (run-tests add-to-end!-tests))
