#lang racket

(require rackunit)
(require rackunit/text-ui)

(define evaluation-tests
  (test-suite
   "Test for evaluation"

   (test-case
     "1."
     (define x 0)
     (define (bump delta)
       (begin
         (set! x (+ x delta))
         x))
     (check-equal?  (+ (bump 2) (bump 3)) 7)
     (check-equal? x 5)
     )

   (test-case
     "2."
     (define x 10)
     (set! x (cond
               [(zero? x) 13]
               [else (/ 1 x)]))
     (check-equal? x 1/10)
     )

   (test-case
     "3."
     (define (make-box x)
       (local ((define contents x)
               (define (new y)
                 (set! contents y))
               (define (peek)
                 contents))
              (list new peek)))

     (define B (make-box 55))
     (define C (make-box 'a))

     (check-equal? 
       (begin
         ((first B) 33)
         ((second C)))
       'a)
     )
   ))

(exit (run-tests evaluation-tests))
