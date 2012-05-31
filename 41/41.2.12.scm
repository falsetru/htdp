#lang racket

(require "41.2.5.scm")
(require "41.2.8.scm")

(define (for-all f items)
  (cond [(empty? items) (void)]
        [else
          (begin
            (f (first items))
            (for-all f (rest items)))]))

(define (all-fed animals)
  (for-all (lambda (animal) (feed-animal animal 'breakfast)) animals))
(define (move-squares sqs delta)
  (for-all (lambda (sq) (move-square! sq delta)) sqs))


(require rackunit)
(require rackunit/text-ui)

(define for-all-tests
  (test-suite
    "Test for for-all"


    (test-case "move-squares"
      (define sqs
        (list (make-square (make-posn 10 10) 10)
              (make-square (make-posn 12 30) 5)
              (make-square (make-posn 0 0) 3)))
      (move-squares sqs 10)
      (check-equal?
        sqs
        (list (make-square (make-posn 20 10) 10)
              (make-square (make-posn 22 30) 5)
              (make-square (make-posn 10 0) 3))))

    (test-case ""
      (define animals
        (list (create-animal 'elephant)
              (create-animal 'monkey)
              (create-animal 'spider)))
      (all-fed animals)
      (check-equal?
        animals
        (list (make-animal 'elephant true false)
              (make-animal 'monkey true false)
              (make-animal 'spider true false))))

    ))

(exit (run-tests for-all-tests))
