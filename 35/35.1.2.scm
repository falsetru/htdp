#lang racket

(require rackunit)
(require rackunit/text-ui)

(define set!-tests
  (test-suite
   "Test for set!"

   (test-case "set!"
    (define x 1)
    (define y 1)
    (check-equal? (local ((define u (set! x (+ x 1)))
                          (define v (set! y (- y 1))))
                         (* x y)) 0)
    )

   (test-case "set!"
    (define x 1)
    (define y 1)
    (check-equal? (local ((define u (void))
                          (define v (void)))
                         (* x y)) 1)
    )
   ))

(exit (run-tests set!-tests))
