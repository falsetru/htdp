#lang racket

(require rackunit)
(require rackunit/text-ui)

(define make-box-tests
  (test-suite
   "Test for make-box"

   (test-case
    "make-box"
    (define (make-box x)
      (local ((define contents x)
              (define (new y) (set! contents y))
              (define (peek) contents))
             (list new peek)))
    (define B (make-box 55))
    (define C B)
    (check-eq? C B)

    (check-equal?
      (and 
        (begin 
          ((first B) 33)
          true)
        (= ((second C)) 33)
        (begin
          (set! B (make-box 44))
          (= ((second C)) 33))) 
      true
      )
    )
   ))

(exit (run-tests make-box-tests))
