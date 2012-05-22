#lang racket

(require "37.5.1.scm")

(define RICE-University
  (list (make-building 'MuddBuilding  'MuddBuilding-pic '(EngineeringQ Bio-Engineers))
        (make-building 'Bio-Engineers 'Bio-Engineers-pic '(MuddBuilding))
        (make-building 'EngineeringQ  'EngineeringQ-pic '(MuddBuilding))))

(define pos (first RICE-University))
(define (show-me) (building-pic pos))
(define (where-to-go)
  (building-near-buildings pos))
(define (go s)
  (local ((define (try-go s buildings)
            (cond [(empty? buildings) (error 'go "No such near building.")]
                  [(symbol=? s (building-name (first buildings)))
                   (set! pos (first buildings))]
                  [else (try-go s (rest buildings))])))
         (try-go s RICE-University)))


(require rackunit)
(require rackunit/text-ui)

(define exploring-tests
  (test-suite
   "Test for exploring"

   (test-case
    "explorer"
    (set! pos (first RICE-University))
    (check-equal? (show-me) 'MuddBuilding-pic)
    (check-equal? (where-to-go) '(EngineeringQ Bio-Engineers))
    (go 'EngineeringQ)
    (check-equal? (show-me) 'EngineeringQ-pic)
    (check-exn exn? (lambda () (go 'Bio-Engineers-pic)))
    )
   ))

(exit (run-tests exploring-tests))
