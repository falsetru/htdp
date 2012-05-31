#lang racket

(provide
  (struct-out posn)
  (struct-out square)
  (struct-out circle)
  move-square!
  move-circle!
  )

(define-struct posn (x y) #:mutable #:transparent)
(define-struct square (nw length) #:mutable #:transparent)
(define-struct circle (center radius) #:mutable #:transparent)
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

(define (move-circle! cc delta)
  (set-posn-x! (circle-center cc)
               (+ (posn-x (circle-center cc)) delta)))



(require rackunit)
(require rackunit/text-ui)

(define move-square!-tests
  (test-suite
   "Test for move-square!"

   (test-case
    "move-square!"
    (define a-sq (make-square (make-posn 5 6) 10))
    (move-square! a-sq 5)
    (check-equal? a-sq (make-square (make-posn 10 6) 10))
    )

   (test-case
    "move-circle!"
    (define a-cc (make-circle (make-posn 10 10) 5))
    (move-circle! a-cc 9)
    (check-equal? a-cc (make-circle (make-posn 19 10) 5))
    )
   ))

(run-tests move-square!-tests)
