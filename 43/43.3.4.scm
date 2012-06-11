;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 43.3.4) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp")))))
(require "43.3.1.scm")
(require "43.3.2.scm")

(define (build-board n f)
  (build-vector
    n (lambda (i) (build-vector
                    n (lambda (j) (f i j))))))

(define (board-ref a-board i j)
  (vector-ref (vector-ref a-board i) j))


(define p make-posn)

(define (threatened? p1 p2)
  (or (= (posn-x p1) (posn-x p2))
      (= (posn-y p1) (posn-y p2))
      (= (- (posn-x p1) (posn-y p1))
         (- (posn-x p2) (posn-y p2)))
      (= (+ (posn-x p1) (posn-y p1))
         (+ (posn-x p2) (posn-y p2)))))

(define (placement n a-board)
  (begin
    (draw-board a-board)
    (cond [(zero? n) a-board]
          [else (try-placement 0 0 n a-board)])))


(define (try-placement i j n a-board)
  (cond [(>= i (vector-length a-board)) false]
        [(>= j (vector-length a-board)) (try-placement (add1 i) 0 n a-board)]
        [(> (board-ref a-board i j) 0)  (try-placement i (add1 j) n a-board)]
        [else
          (begin
            (place-queen a-board i j)
            (local ((define a-try (placement (sub1 n) a-board)))
                   (cond [(false? a-try)
                          (begin
                            (unplace-queen a-board i j)
                            (placement (sub1 n) a-board))]
                         [else a-try])))]
          ))


(define (draw-board board)
  (local ((define xs (build-list (vector-length board) identity)))
    (begin
      (sleep-for-a-while 0.1)
      (clear-all)
      (for-each
       (lambda (i)
         (for-each
          (lambda (j)
            (local ((define p (make-posn (+ 10 (* i 30)) (+ 10 (* j 30)))))
              (cond [(zero? (board-ref board i j)) (draw-solid-disk p 10 'blue)]
                    [else (draw-solid-disk p 10 'red)])))
          xs))
       xs))))

(start 500 500)
(define a-board (build-board 8 (lambda (i j) 0)))
(placement 8 a-board)