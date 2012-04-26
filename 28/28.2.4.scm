(define-struct posn (x y))
(define p make-posn)

(define (threatened? p1 p2)
  (or (= (posn-x p1) (posn-x p2))
      (= (posn-y p1) (posn-y p2))
      (= (- (posn-x p1) (posn-y p1))
         (- (posn-x p2) (posn-y p2)))
      (= (+ (posn-x p1) (posn-y p1))
         (+ (posn-x p2) (posn-y p2)))))


(define (build-board n f)
  (build-list n (lambda (row)
                  (build-list n (lambda (col)
                                  (f row col))))))

(define (board-ref a-board i j)
  (list-ref (list-ref a-board i) j))

(define (placement n a-board)
  (cond [(zero? n) a-board]
        [else (try-placement 0 0 n a-board)]))

(define (try-placement i j n a-board)
  (cond [(>= i (length a-board)) false]
        [(>= j (length a-board))
         (try-placement (add1 i) 0 n a-board)]
        [(not (equal? (board-ref a-board i j) true))
         (try-placement i (add1 j) n a-board)]
        [else
          (local ((define (mark ii jj)
                    (if (or (and (= i ii) (= j jj)) (equal? (board-ref a-board ii jj) '**))
                      '**
                      (and (equal? (board-ref a-board ii jj) true)
                           (not (threatened? (make-posn i j)
                                             (make-posn ii jj))))))
                  (define a-board-marked (build-board (length a-board) mark))
                  (define a-try (placement (sub1 n) a-board-marked)))
                 (if (false? a-try)
                   (try-placement i (add1 j) n a-board)
                   a-try))]))

(require rackunit)
(require rackunit/text-ui)

(define placement-tests
  (test-suite
   "Test for placement"

   (check-equal? (placement 0 '((#t))) '((#t)))
   (check-equal? (placement 0 '((#f))) '((#f)))
   (check-equal? (placement 1 '((#t))) '((**)))
   (check-equal? (placement 1 '((#f))) false)

   (check-equal? (placement 1 '((#t #t)
                                (#t #t)))
                 '((** #f)
                   (#f #f)))

   (check-equal? (placement 2 '((#t #t)
                                (#t #t)))
                 false)

   (check-equal? (placement 1 '((#t #t #t)
                                (#t #t #t)
                                (#t #t #t)))
                 '((** #f #f)
                   (#f #f #t)
                   (#f #t #f)))

   (check-equal? (placement 2 '((#t #t #t)
                                (#t #t #t)
                                (#t #t #t)))
                 '((** #f #f)
                   (#f #f **)
                   (#f #f #f)))

   (test-case
    "8x8"
    (check-equal? 1 1)
    (define solution (placement 8 (build-board 8 (lambda (i j) #t))))
    (for-each
      (lambda (x) (check-not-equal? x #t))
      (foldr append empty
             solution))
    (for-each
      (lambda (x) (printf "~s\n" x))
      solution)
    )
   ))
     

(exit (run-tests placement-tests))
