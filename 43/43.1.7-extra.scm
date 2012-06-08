#lang racket

(require "../41/41.2.17.scm")

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
         (vec-for-all
           (lambda (x)
             (local ((define ret temp))
                    (begin
                      (set! temp x)
                      ret)))
           v)))

(define (insert-i-j v i j)
  (local ((define temp (vector-ref v j))
          (define idx (sub1 (vector-length v))))
         (vec-for-all
           (lambda (x)
             (local ((define ret
                       (cond [(= idx i) temp]
                             [(<= (add1 i) idx j) (vector-ref v (sub1 idx))]
                             [else x])))
                    (begin
                      (set! idx (sub1 idx))
                      ret)))
           v)))

(define (vector-reverse! v)
  (local ((define offset (ceiling (/ (vector-length v) 2)))
          (define middle (floor (/ (vector-length v) 2)))
          (define i (vector-length v))
          (define i-- (lambda () (set! i (sub1 i))))
          (define temp (make-vector offset)))
         (vec-for-all
           (lambda (x)
             (begin
               (i--)
               (cond
                 [(>= i offset)
                  (begin
                    (vector-set! temp (- i offset) x)
                    (vector-ref v (- i offset)))]
                 [(= i middle) x]
                 [else (vector-ref temp i)])
               ))
           v)))

(define (find-new-right V the-pivot left right)
  (local ((define result left)
          (define i (vector-length V))
          (define (i--) (set! i (sub1 i))))
         (begin
           (vec-for-all
             (lambda (x)
               (i--)
               (cond
                 [(and (< x the-pivot) (<= left i right)) (set! result (max i result))]
                 [else (void)])
               x)
             V)
           result)))

(define (vector-sum! v)
  (local ((define sum 0))
         (begin
           (vec-for-all
             (lambda (x) (set! sum (+ sum x)))
             v)
           sum)))

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
