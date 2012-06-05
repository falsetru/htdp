#lang racket

(define (in-place-sort V)
  (local (;; sort-aux : (vectorof number) N  ->  void
	  ;; effect: to sort the interval [0,i) of V in place 
	  (define (sort2-aux i)
	    (cond
	      [(zero? i) (void)]
	      [else (begin
                      (insert2 (sub1 i))
		      (sort2-aux (sub1 i))
		      )]))
	  
	  ;; insert : N (vectorof number)  ->  void
	  ;; to place the value in the i-th into its proper place 
	  ;; in the segement [0,i] of V
	  ;; assume: the segment  [0,i) of V is sorted
	  (define (insert2 i) 
            (local ((define (insert-aux j)
                      (cond [(= j i) (void)]
                            [(< (vector-ref V j) (vector-ref V (add1 j)))
                             (insert-aux (add1 j))]
                            [else
                             (begin
                               (swap j (add1 j))
                               (insert-aux (add1 j)))]
                            )))
                   (insert-aux 0)))
	  
	  ;; swap : (vectorof X) N N void 
	  (define (swap i j)
	    (local ((define temp (vector-ref V i)))
	      (begin
		(vector-set! V i (vector-ref V j))
		(vector-set! V j temp))))
	  )
    (sort2-aux (vector-length V))))

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
