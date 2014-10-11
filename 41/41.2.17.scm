#lang racket

(provide
  vec-for-all)

;; vec-for-all : (N X  ->  void) (vectorof X)  ->  void
;; effect: to apply f to all indices and values in vec
;; equation: 
;; (vec-for-all f (vector v-0 ... v-N)) 
;; = 
;; (begin (f N v-N) ... (f 0 v-0) (void))
(define (vec-for-all f vec)
  (vec-for-all-aux f vec (vector-length vec)))

(define (vec-for-all-aux f v i)
  (cond [(zero? i) (void)]
        [else
          (begin
            (vector-set! v (sub1 i) (f (vector-ref v (sub1 i)) (sub1 i)))
            (vec-for-all-aux f v (sub1 i)))]))

(define (vector*! s v)
  (vec-for-all (lambda (value index) (* value s)) v))

(require rackunit)
(require rackunit/text-ui)

(define vector*!-tests
  (test-suite
   "Test for vector*!"

   (test-case
    ""
    (define v (vector 1 2 3 4 5))
    (vector*! 2 v)
    (check-equal? v '#(2 4 6 8 10))
    )
   ))

(run-tests vector*!-tests)
