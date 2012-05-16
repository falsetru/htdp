#lang racket

(define COLORS
  '(black white red blue green gold pink orange purple navy))
(define COL# (length COLORS))

(define target1 (first COLORS))
(define target2 (first COLORS))

(define (random-pick xs)
  (list-ref xs (random (length xs))))

(define (master)
  (begin (set! target1 (random-pick COLORS))
         (set! target2 (random-pick COLORS))))

(require rackunit)
(require rackunit/text-ui)

(define random-pick-tests
  (test-suite
   "Test for random-pick"

   (test-case
    "master"
    (master)
    (check-true (cons? (memq target1 COLORS)))
    (check-true (cons? (memq target2 COLORS)))
    )
   ))

(exit (run-tests random-pick-tests))
