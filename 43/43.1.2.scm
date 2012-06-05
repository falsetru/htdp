#lang racket

(define (in-place-sort V)
  (local (;; sort-aux : (vectorof number) N  ->  void
	  ;; effect: to sort the interval [0,i) of V in place 
	  (define (sort-aux i)
	    (cond
	      [(zero? i) (void)]
	      [else (begin
		      ;; sort the segment [0,(sub1 i)):
		      (sort-aux (sub1 i))
		      ;; insert (vector-ref V (sub1 i)) into the segment 
		      ;; [0,i) so that it becomes sorted''
		      (insert (sub1 i) (vector-ref V (sub1 i))))]))
	  
	  ;; insert : N (vectorof number)  ->  void
	  ;; to place the value in the i-th into its proper place 
	  ;; in the segement [0,i] of V
	  ;; assume: the segment  [0,i) of V is sorted
	  (define (insert i d)
	    (cond
	      [(or (zero? i) (<= (vector-ref V (sub1 i)) d))
               (vector-set! V i d)]
              [else 
               (begin
                 (vector-set! V i (vector-ref V (sub1 i)))
                 (insert (sub1 i) d))]))
	  )
    (sort-aux (vector-length V))))

(require rackunit)
(require rackunit/text-ui)

(define in-place-sort-tests
  (test-suite
   "Test for in-place-sort"

   (test-case
    ""
    (define v1 (vector 7 3 0 4 1))
    (in-place-sort v1)
    (check-equal? v1 (vector 0 1 3 4 7))
    )

   ))

(exit (run-tests in-place-sort-tests))
