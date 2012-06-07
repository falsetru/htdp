#lang racket

(define (vector-reverse! v)
  (local ((define (reverse-aux l r)
            (cond [(>= l r) (void)]
                  [else
                    (begin
                      (swap v l r)
                      (reverse-aux (add1 l) (sub1 r)))])))
         (reverse-aux 0 (sub1 (vector-length v)))))

(define (swap V i j)
  (local ((define temp (vector-ref V i)))
         (begin
           (vector-set! V i (vector-ref V j))
           (vector-set! V j temp))))


(require rackunit)
(require rackunit/text-ui)

(define vector-reverse!-tests
  (test-suite
   "Test for vector-reverse!"

   (test-case
    ""
    (define v (vector 2 3 5 1 4 0))
    (vector-reverse! v)
    (check-equal? v '#(0 4 1 5 3 2))
    )
   ))

(exit (run-tests vector-reverse!-tests))
