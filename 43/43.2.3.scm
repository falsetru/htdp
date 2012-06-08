#lang racket

(require "43.2.1.scm")

(define (how-many-descendants ftn)
  (cond [(false? ftn) 0]
        [else
          (+ 1
             (foldr + 0 (map how-many-descendants (person-children ftn))))]))

(require rackunit)
(require rackunit/text-ui)

(define how-many-descendants-tests
  (test-suite
   "Test for how-many-descendants"

   (check-equal? (how-many-descendants Gustav) 1)
   (check-equal? (how-many-descendants Carl) 5)
   (check-equal? (how-many-descendants Eva) 2)
   ))

(exit (run-tests how-many-descendants-tests))
