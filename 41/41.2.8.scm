#lang racket

(provide
  (struct-out animal)
  create-animal
  feed-animal)

(define-struct animal (name breakfast dinner) #:transparent #:mutable)
(define (create-animal name) (make-animal name false false))
(define (feed-animal animal time)
  (cond [(symbol=? time 'breakfast) (set-animal-breakfast! animal true)]
        [(symbol=? time 'dinner) (set-animal-dinner! animal true)]))

(require rackunit)
(require rackunit/text-ui)

(define feed-animal-tests
  (test-suite
   "Test for feed-animal"

   (test-case
    ""
    (define monkey (create-animal 'monkey))
    (feed-animal monkey 'breakfast)
    (check-equal? monkey (make-animal 'monkey true false))
    (feed-animal monkey 'dinner)
    (check-equal? monkey (make-animal 'monkey true true))
    )
   ))

(run-tests feed-animal-tests)
