#lang racket


(provide
  toggle-board!
  move
  unmove)

; peg-move is list of source, dest
;   source is (listof 2 number)
;   dest is (listof 2 number)

(define (toggle-board! board pos)
  (vector-set! (vector-ref board (first pos)) (second pos)
               (not (vector-ref (vector-ref board (first pos)) (second pos)))))

(define (move board peg-move)
  (for-each
    (lambda (m) (toggle-board! board m))
    peg-move))

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
    (move board '((0 0) (1 1) (2 2)))
    (check-equal? board '#(#(#t)
                           #(#f #t)
                           #(#f #f #f)))
    (unmove board '((0 0) (1 1) (2 2)))
    (check-equal? board '#(#(#f)
                           #(#f #f)
                           #(#f #f #t)))
    )
   ))

(run-tests move-unmove-tests)
