#lang racket

(require "../32/32.3.2.scm")
(require "43.3.6.scm")

(define (done? board)
  (=
    (foldr + 0 (map (lambda (v) (vector-count false? v)) (vector->list board)))
    1))

(define (enabled-pos/all board)
  (local ((define (collect r c acc)
            (cond [(>= r (vector-length board)) acc]
                  [(> c r) (collect (add1 r) 0 acc)]
                  [else (local ((define x (enabled?-pos board (list r c))))
                               (cond [(false? x) (collect r (add1 c) acc)]
                                     [else (collect r (add1 c) (cons x acc))]))])))
         (collect 0 0 empty)))

(define (solve* b pos-list trail)
  (cond [(empty? pos-list) false]
        [else
          (begin
            (move b (first pos-list))
            (local ((define result (solve1 b (cons (first pos-list) trail))))
                   (cond [(false? result)
                          (begin
                            (unmove b (first pos-list))
                            (solve* b (rest pos-list) trail))]
                         [else result])))]))

(define (solve1 b trail)
  (cond [(done? b) trail]
        [else (local ((define pos-list (enabled-pos/all b)))
                     (solve* b pos-list trail))]))

(define (solitaire board)
  (local ((define result (solve1 board empty)))
         (cond [(false? result) false]
               [else (reverse result)])))

(require rackunit)
(require rackunit/text-ui)

(define solitaire-tests
  (test-suite
   "Test for solitaire"

   (test-case "done?"
    (check-equal? (done? '#(#(#t)
                            #(#t #f)))
                  true)
    (check-equal? (done? '#(#(#f)
                            #(#t #t)))
                  true)
    (check-equal? (done? '#(#(#t)
                            #(#f #t)))
                  true)
    (check-equal? (done? '#(#(#f)
                            #(#f #t)))
                  false)
    (check-equal? (done? '#(#(#t)
                            #(#f #f)))
                  false))

   (test-case "enabled-pos/all"
    (check-equal? (enabled-pos/all example-board)
                  '(((2 0) (2 1) (2 2))
                    ((0 0) (1 1) (2 2)))))

   (test-case
    "solitaire"
    (check-equal? (solitaire (vector (vector #t)
                                     (vector #f #t)
                                     (vector #f #t #t)))
                  '(((2 0) (1 0) (0 0))))
    (check-equal? (solitaire (vector (vector #t))) false)
    (check-equal? (solitaire example-board)
                  '(((0 0) (1 1) (2 2))
                    ((3 3) (2 2) (1 1))
                    ((3 1) (3 2) (3 3))
                    ((1 1) (2 1) (3 1))
                    ((3 0) (3 1) (3 2))
                    ((3 3) (3 2) (3 1))
                    ((1 0) (2 0) (3 0))
                    ((3 0) (3 1) (3 2))))
    )
   ))

(exit (run-tests solitaire-tests))
