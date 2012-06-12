#lang racket

; peg-move is list of source, dest
;   source is (listof 2 number)
;   dest is (listof 2 number)

(define (mid-point peg-move)
  (list (/ (+ (first (first peg-move)) (first (second peg-move))) 2)
        (/ (+ (second (first peg-move)) (second (second peg-move))) 2)))

(define (toggle-board board pos)
  (vector-set! (vector-ref board (first pos)) (second pos)
               (not (vector-ref (vector-ref board (first pos)) (second pos)))))

(define (move board peg-move)
  (begin
    (toggle-board board (first peg-move))
    (toggle-board board (second peg-move))
    (toggle-board board (mid-point peg-move))))

(define unmove move)

(require rackunit)
(require rackunit/text-ui)

(define move-unmove-tests
  (test-suite
   "Test for move-unmove"

   (test-case
    ""
    (define board (vector (vector false)
                          (vector false false)
                          (vector false false true)))
    (move board '((0 0) (2 2)))
    (check-equal? board '#(#(#t)
                           #(#f #t)
                           #(#f #f #f)))
    (unmove board '((0 0) (2 2)))
    (check-equal? board '#(#(#f)
                           #(#f #f)
                           #(#f #f #t)))
    )
   ))

(exit (run-tests move-unmove-tests))
