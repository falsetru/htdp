#lang racket

;; call-status : (vectorof boolean)
;; to keep track of the floors from which calls have been issued 
(define call-status (vector true true true false true true true false))

;; reset :  ->  void
;; effect: to set all fields in call-status to false
(define (reset)
  (reset-aux call-status (vector-length call-status)))

;; reset-aux : (vectorof boolean) N  ->  void
;; effect: to set the fields of v with index in [0, i) to false
(define (reset-aux v i)
  (cond
    [(zero? i) (void)]
    [else (begin
	    (vector-set! v (sub1 i) false)
	    (reset-aux v (sub1 i)))]))


(require rackunit)
(require rackunit/text-ui)

(define reset-aux-tests
  (test-suite
   "Test for reset-aux"

   (test-case
    ""
    (define v (vector #t #t #t #t #t #t #t))
    (reset-aux v 3)
    (check-equal? v '#(#f #f #f #t #t #t #t))
    (reset-aux v (vector-length v))
    (check-equal? v '#(#f #f #f #f #f #f #f))
    )
   ))

(exit (run-tests reset-aux-tests))
