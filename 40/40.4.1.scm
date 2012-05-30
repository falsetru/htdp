#lang racket


(require rackunit)
(require rackunit/text-ui)

(define vector-set-tests
  (test-suite
   "Test for vector-set"

   (test-case ""
     (define X (vector 0 0 0 0))
     (define Y X)
     (check-equal?
       (begin
         (vector-set! X 0 2)
         (vector-set! Y 1 (+ (vector-ref Y 0) (vector-ref Y 1)))
         (vector-ref Y 1))
       2)
     (check-equal? X '#(2 2 0 0))
     (check-equal? Y '#(2 2 0 0)))
   ))

(exit (run-tests vector-set-tests))
