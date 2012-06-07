#lang racket

(define (list-3-averages xs)
  (build-list
    (- (length xs) 2)
    (lambda (i) (/ (+ (list-ref xs (+ i 0))
                      (list-ref xs (+ i 1))
                      (list-ref xs (+ i 2))) 3))))

(define (vector-3-averages xs)
  (build-vector
    (- (vector-length xs) 2)
    (lambda (i) (/ (+ (vector-ref xs (+ i 0))
                      (vector-ref xs (+ i 1))
                      (vector-ref xs (+ i 2))) 3))))

(define (vector-3-averages! xs result)
  (local ((define (avg-aux i)
            (cond [(>= i (vector-length result)) (void)]
                  [else
                    (begin
                      (vector-set!
                        result i
                        (/ (+ (vector-ref xs (+ i 0))
                              (vector-ref xs (+ i 1))
                              (vector-ref xs (+ i 2)))
                           3))
                      (avg-aux (add1 i)))
                    ])
            ))
         (avg-aux 0)))

(require rackunit)
(require rackunit/text-ui)

(define average-tests
  (test-suite
   "Test for average"

   (test-case
    "list-3-averages"
    (define numbers '(110/100 112/100 108/100 109/100 111/100))
    (check-equal? (list-3-averages numbers) '(110/100 329/300 82/75))
    )

   (test-case
    "vector-3-averages"
    (define numbers '#(110/100 112/100 108/100 109/100 111/100))
    (check-equal? (vector-3-averages numbers) '#(110/100 329/300 82/75))
    )

   (test-case
    "vector-3-averages!"
    (define numbers '#(110/100 112/100 108/100 109/100 111/100))
    (define result (make-vector (- (vector-length numbers)2) 0))
    (vector-3-averages! numbers result)
    (check-equal? result '#(110/100 329/300 82/75))
    )
   ))

(exit (run-tests average-tests))
