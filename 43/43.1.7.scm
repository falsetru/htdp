#lang racket

(define (swap V i j)
  (local ((define temp (vector-ref V i)))
         (begin
           (vector-set! V i (vector-ref V j))
           (vector-set! V j temp))))

(define (for-interval i end? step action)
  (cond
    [(end? i) (action i)]
    [else (begin
	    (action i)
	    (for-interval (step i) end? step action))]))

(define (rotate-left v)
  (local ((define temp (vector-ref v 0)))
         (for-interval
           0
           (lambda (i) (= i (sub1 (vector-length v))))
           add1
           (lambda (i)
             (vector-set! v i
               (cond [(= i (sub1 (vector-length v))) temp]
                     [else (vector-ref v (add1 i))]))))))

(define (insert-i-j v i j)
  (local ((define temp (vector-ref v j)))
         (for-interval
           j
           (lambda (x) (= x i))
           sub1
           (lambda (x)
             (vector-set! v x
               (cond [(= x i) temp]
                     [else (vector-ref v (sub1 x))]))))))

(define (vector-reverse! v)
  (local ((define offset (ceiling (/ (vector-length v) 2)))
          (define startpos (sub1 (floor (/ (vector-length v) 2)))))
         (for-interval
           startpos
           zero?
           sub1
           (lambda (i) (swap v i (+ i offset))))))

(define (find-new-right V the-pivot left right)
  (for-interval
    right
    (lambda (i) (or (= i left) (< (vector-ref V i) the-pivot)))
    sub1
    identity))

(define (vector-sum! v)
  (local ((define sum 0))
         (for-interval
           (sub1 (vector-length v))
           zero?
           sub1
           (lambda (i)
             (begin
               (set! sum (+ sum (vector-ref v i)))
               sum)))
         ))

(require rackunit)
(require rackunit/text-ui)

(define for-interval-tests
  (test-suite
   "Test for for-interval"

   (test-case
    "1. rotate-left"
    (define v (vector 1 2 3 4 5))
    (rotate-left v)
    (check-equal? v '#(2 3 4 5 1))
    )

   (test-case
    "2. insert-i-j v i j"
    (define v (vector 1 2 3 4 5))
    (insert-i-j v 1 3)
    (check-equal? v '#(1 4 2 3 5))
    )

   (test-case
    "3. vector-reverse!"
    (define v (vector 1 2 3 4 5))
    (vector-reverse! v)
    (check-equal? v '#(4 5 3 1 2))

    (define v2 (vector 1 2 3 4))
    (vector-reverse! v2)
    (check-equal? v2 '#(3 4 1 2))
    )

   (test-case
    "4. find-new-right"
    (define v (vector 3 1 2 4 5))
    (check-equal? (find-new-right v 3 3 4) 3)
    (check-equal? (find-new-right v 3 0 4) 2)
    )

   (test-case
    "5. vector-sum!"
    (define v (vector 1 2 3 4 5))
    (check-equal? (vector-sum! v) 15)
    )

   ))

(exit (run-tests for-interval-tests))
