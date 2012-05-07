#lang racket

(require "32.3.1.scm")

(define neighbors '((0 1) (0 -1) (1 0) (1 1) (-1 -1) (-1 0)))
(define moves     '((0 2) (0 -2) (2 0) (2 2) (-2 -2) (-2 0)))
(define directions (map list neighbors moves))

(define (pos+ a b)
  (list (+ (first a) (first b)) (+ (second a) (second b))))
(define (valid-pos? board pos)
  (<= 0 (second pos) (first pos) (sub1 (vector-length board))))

(define (board-ref board p) (vector-ref (vector-ref board (first p)) (second p)))
(define (peg? board p) (false? (board-ref board p)))
(define (hole? board p) (not (peg? board p)))

(define (toggle-board board p)
  (local ((define r (first p))
          (define c (second p)))
         (build-vector (vector-length board) (lambda (i)
           (build-vector (add1 i) (lambda (j)
             (cond [(and (= i r) (= j c)) (not (board-ref board (list i j)))]
                   [else (board-ref board (list i j))])))))))
(define (toggle-board/list board ps)
  (cond [(empty? ps) board]
        [else (toggle-board/list (toggle-board board (first ps)) (rest ps))]))

(define (enabled?-pos board pos)
  (local ((define (visit unvisited)
            (cond [(empty? unvisited) false]
                  [else
                    (local ((define p1 (pos+ pos (first (first unvisited))))
                            (define p2 (pos+ pos (second (first unvisited)))))
                           (cond [(or (and (valid-pos? board p1)
                                           (valid-pos? board p2)
                                           (peg? board p1)
                                           (hole? board p2)))
                                  (list pos p1 p2)]
                                 [else (visit (rest unvisited))]))])))
         (visit directions)))

(define (enabled? board pos) (not (false? (enabled?-pos board pos))))

(define (next-configuration board p)
  (local ((define movement (enabled?-pos board p)))
         (toggle-board/list board movement)))

(require rackunit)
(require rackunit/text-ui)

(define enabled?-next-configuration-tests
  (test-suite
   "Test for enabled?-next-configuration"

   (test-case "valid-pos?"
    (check-equal? (valid-pos? example-board '(0 0)) true)
    (check-equal? (valid-pos? example-board '(3 3)) true)
    (check-equal? (valid-pos? example-board '(0 1)) false)
    (check-equal? (valid-pos? example-board '(0 -1)) false)
    (check-equal? (valid-pos? example-board '(-1 0)) false)
    (check-equal? (valid-pos? example-board '(3 4)) false))

   (test-case "enabled?"
     (check-equal? (enabled? example-board '(0 0)) true)
     (check-equal? (enabled? example-board '(1 1)) false)
     (check-equal? (enabled? example-board '(2 0)) true))

   (test-case "toggle-board toggle-board/list"
    (check-equal? 
      (toggle-board '#(#(#t)
                       #(#f #t)
                       #(#f #f #t)
                       #(#f #f #f #f)) '(2 2))
      '#(#(#t)
         #(#f #t)
         #(#f #f #f)
         #(#f #f #f #f)))
    (check-equal?
      (toggle-board/list example-board '((0 0) (1 1) (2 2)))
      '#(#(#t)
         #(#f #t)
         #(#f #f #f)
         #(#f #f #f #f))))

   (test-case "next-configuration"
    (check-equal? (next-configuration example-board '(0 0))
                  '#(#(#t)
                     #(#f #t)
                     #(#f #f #f)
                     #(#f #f #f #f)))
    (check-equal? (next-configuration example-board '(2 0))
                  '#(#(#f)
                     #(#f #f)
                     #(#t #t #f)
                     #(#f #f #f #f)))
    )

   ))

(exit (run-tests enabled?-next-configuration-tests))
