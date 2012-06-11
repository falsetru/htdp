#lang racket

(require "43.3.1.scm")
(require "43.3.2.scm")

(define (build-board n f)
  (build-vector
    n (lambda (i) (build-vector
                    n (lambda (j) (f i j))))))

(define (board-ref a-board i j)
  (vector-ref (vector-ref a-board i) j))


(define-struct posn (x y))
(define p make-posn)

(define (threatened? p1 p2)
  (or (= (posn-x p1) (posn-x p2))
      (= (posn-y p1) (posn-y p2))
      (= (- (posn-x p1) (posn-y p1))
         (- (posn-x p2) (posn-y p2)))
      (= (+ (posn-x p1) (posn-y p1))
         (+ (posn-x p2) (posn-y p2)))))

(define (placement n a-board)
  (cond [(zero? n) a-board]
        [else (try-placement 0 0 n a-board)]))

(define (try-placement i j n a-board)
  (cond [(>= i (vector-length a-board)) false]
        [(>= j (vector-length a-board))
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
                  (define _dummy_ (place-queen a-board i j))
                  (define a-try (placement (sub1 n) a-board)))
                 (if (false? a-try)
                   (begin
                     (unplace-queen a-board i j)
                     (try-placement i (add1 j) n a-board))
                   a-try))]))




(require rackunit)
(require rackunit/text-ui)

(define board-tests
  (test-suite
   "Test for board"

   (test-case "build-board"
    (check-equal? (build-board 3 (lambda (i j) false))
                  (vector (vector false false false)
                          (vector false false false)
                          (vector false false false)))
    (check-equal? (build-board 3 (lambda (i j) (= i j)))
                  (vector (vector true  false false)
                          (vector false true  false)
                          (vector false false true ))))

   (test-case "board-ref"
    (define a-board (vector (vector true  false false)
                            (vector false true  false)
                            (vector false false true )))
    (check-equal? (board-ref a-board 0 0) true)
    (check-equal? (board-ref a-board 0 1) false)
    (check-equal? (board-ref a-board 2 2) true))

   (test-case
    "8x8"
    (check-equal? 1 1)
    (define solution (placement 8 (build-board 8 (lambda (i j) #t))))
    (for-each
      (lambda (x) (check-not-equal? x #t))
      (foldr append empty
             (map vector->list (vector->list solution))))
    (for-each
      (lambda (x) (printf "~s\n" x))
      (vector->list solution))
    )
   ))

(exit (run-tests board-tests))
