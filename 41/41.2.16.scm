#lang racket

(define (move! pos v)
  (move!-aux pos v (sub1 (vector-length pos))))

(define (move!-aux pos v i)
  (cond [(< i 0) (void)]
        [else
          (begin
            (vector-set! pos i
                         (+ (vector-ref pos i)
                            (vector-ref v   i)))
            (move!-aux pos v (sub1 i)))]))

(require rackunit)
(require rackunit/text-ui)

(define move!-tests
  (test-suite
   "Test for move!"

   (test-case
    ""
    (define pos (vector 5 5))
    (define pos2 (vector 5 5 1 9 0))
    (move! pos '#(1 2))
    (check-equal? pos '#(6 7))
    (move! pos2 '#(5 5 9 1 -10))
    (check-equal? pos2 '#(10 10 10 10 -10))
    )
   ))

(exit (run-tests move!-tests))
