;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 43.3.8) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp")))))
(require "../32/32.3.2.scm")
(require "43.3.6.scm")

(define (vector-count f v)
  (local ((define (count-aux i)
            (cond [(< i 0) 0]
                  [(f (vector-ref v i)) (add1 (count-aux (sub1 i)))]
                  [else (count-aux (sub1 i))])))
    (count-aux (sub1 (vector-length v)))))

(define (vector->list v)
  (local ((define (map-aux i)
            (cond [(>= i (vector-length v)) empty]
                  [else (cons (vector-ref v i) (map-aux (add1 i)))])))
    (map-aux 0)))

(define (vector-for-each f v)
  (local ((define (for-each-aux i)
            (cond [(>= i (vector-length v)) (void)]
                  [else
                   (begin
                     (f i (vector-ref v i))
                     (for-each-aux (add1 i))
                     )])))
    (for-each-aux 0)))

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
            (draw-board b)
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


(define (draw-board b)
  (begin
    (sleep-for-a-while 1)
    (clear-all)
    (vector-for-each
     (lambda (i row)
       (vector-for-each
        (lambda (j x)
          (local ((define pos (make-posn (+ (* i 30) 20)
                                         (- (* (vector-length b) 30) (* j 30)))))
            (cond [x (draw-circle pos 10 'black)]
                  [else (draw-solid-disk pos 10 'black)])))
        row))
     b)))

(start 500 500)
(solitaire example-board)