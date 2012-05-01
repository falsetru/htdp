(define (build-board n f)
  (build-vector
    n (lambda (i) (build-vector
                    n (lambda (j) (f i j))))))

(define (board-ref a-board i j)
  (vector-ref (vector-ref a-board i) j))

(define (transpose a-board)
  (build-board (vector-length a-board)
               (lambda (i j) (board-ref a-board j i))))

(require rackunit)
(require rackunit/text-ui)

(define transpose-tests
  (test-suite
   "Test for transpose"

   (check-equal? (transpose #(#(1 0 -1)
                              #(2 0 9)
                              #(1 1 1)))
                 #(#(1 2 1)
                   #(0 0 1)
                   #(-1 9 1)))
   ))

(exit (run-tests transpose-tests))
