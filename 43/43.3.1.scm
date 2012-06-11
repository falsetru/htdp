#lang racket

(provide
  board-for-all
  place-queen)

(define (board-for-all f board)
  (local ((define N (vector-length board)))
    (for-each (lambda (i)
      (for-each (lambda (j)
        (vector-set!
          (vector-ref board i) j
          (f i j (vector-ref (vector-ref board i) j))))
        (build-list N identity)))
      (build-list N identity))))

(define (place-queen board i j)
  (board-for-all (lambda (I J x)
    (cond [(or (= i I)
               (= j J)
               (= (+ i j) (+ I J))
               (= (- i j) (- I J)))
           false]
          [else x]))
    board))

(require rackunit)
(require rackunit/text-ui)

(define place-queen-tests
  (test-suite
   "Test for place-queen"

   (test-case
    ""
    (define board
      (build-vector
        3
        (lambda (i)
          (build-vector
            3
            (lambda (j) true)))))
    (place-queen board 0 0)
    (check-equal?
      board
      '#(#(#f #f #f)
         #(#f #f #t)
         #(#f #t #f)))
    )
   ))

(run-tests place-queen-tests)
