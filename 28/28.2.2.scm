(define (build-board n f)
  (build-list n (lambda (row)
                  (build-list n (lambda (col)
                                  (f row col))))))

(define (board-ref a-board i j)
  (list-ref (list-ref a-board i) j))

(require rackunit)
(require rackunit/text-ui)

(define build-board+board-ref-tests
  (test-suite
   "Test for build-board+board-ref"

   (test-case
    "build-board board-ref"
    (define a-board '((#f #t) (#t #f)))
    (check-equal? (build-board 2 (lambda (i j) (= (+ i j) 1))) a-board)
    (check-equal? (board-ref a-board 0 0) #f)
    (check-equal? (board-ref a-board 0 1) #t)
    (check-equal? (board-ref a-board 1 0) #t)
    (check-equal? (board-ref a-board 1 1) #f)
    )
   ))

(exit (run-tests build-board+board-ref-tests))
