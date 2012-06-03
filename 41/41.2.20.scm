#lang racket

(define (histogram grades)
  (local ((define (histogram-ac grades counts)
            (cond [(empty? grades) counts]
                  [else
                    (begin
                      (vector-set!
                        counts
                        (first grades)
                        (add1 (vector-ref counts (first grades))))
                      (histogram-ac (rest grades) counts))])))
         (histogram-ac grades (build-vector 101 (lambda (i) 0)))))

(require rackunit)
(require rackunit/text-ui)

(define histogram-tests
  (test-suite
   "Test for histogram"

   (test-case
    ""
    (define h (histogram '(1 1 1 10 100 100 9 100 100)))
    (check-equal? (vector-ref h 0) 0)
    (check-equal? (vector-ref h 9) 1)
    (check-equal? (vector-ref h 10) 1)
    (check-equal? (vector-ref h 100) 4)
    )
   ))

(exit (run-tests histogram-tests))
