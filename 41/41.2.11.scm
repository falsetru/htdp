#lang racket

(require "41.2.8.scm")

(define (all-fed animals)
  (cond [(empty? animals) (void)]
        [else
          (begin
            (feed-animal (first animals) 'breakfast)
            (all-fed (rest animals)))]))

(require rackunit)
(require rackunit/text-ui)

(define all-fed-tests
  (test-suite
   "Test for all-fed"

   (test-case
     ""
     (define animals
       (list (create-animal 'elephant)
             (create-animal 'monkey)
             (create-animal 'spider)))
     (all-fed animals)
     (check-equal?
       animals
       (list (make-animal 'elephant true false)
             (make-animal 'monkey true false)
             (make-animal 'spider true false)))
     )
   ))

(exit (run-tests all-fed-tests))
