#lang racket

(define-struct posn (x y) #:mutable #:transparent)
(define-struct square (nw length) #:mutable #:transparent)
; nw: posn
; length: number

;(define (move-square! sq delta)
;  (set-square-nw!
;    sq
;    (make-posn
;      (+ (posn-x (square-nw sq)) delta)
;      (posn-y (square-nw sq)))))

(define (move-square! sq delta)
  (set-posn-x! (square-nw sq)
               (+ (posn-x (square-nw sq)) delta)))



(require rackunit)
(require rackunit/text-ui)

(define move-square!-tests
  (test-suite
   "Test for move-square!"

   (test-case
    "+5"
    (define a-sq (make-square (make-posn 5 6) 10))
    (move-square! a-sq 5)
    (check-equal? a-sq (make-square (make-posn 10 6) 10))
    )
   ))

(exit (run-tests move-square!-tests))
