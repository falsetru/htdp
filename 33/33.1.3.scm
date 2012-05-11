#lang racket

(define (add n)
  (local ((define (add-acc n acc)
            (cond [(zero? n) acc]
                  [else (add-acc (sub1 n) (+ acc #i1/185))])))
         (add-acc n 0)))

(define (sub n)
  (local ((define (sub-acc n acc)
            (cond [(zero? n) acc]
                  [else (sub-acc (- n 1/185) (add1 acc))])))
         (sub-acc n 0)))


(require rackunit)
(require rackunit/text-ui)

(define add-sub-tests
  (test-suite "Test for add-sub"

   (test-case "add"
    (define x (add 185))
    (check-not-equal? x 1)
    (check-not-equal? (* x 100000000) 100000000))

   (test-case "sub"
    (check-equal? (sub 1) 185)
    ;(check-not-equal? (sub #i1.0) 185) ; never end.
    )
   ))

(exit (run-tests add-sub-tests))
