#lang racket

(define-struct posn (x y) #:mutable #:transparent)

(define (eq-posn p1 p2)
  (local (;; save old x values of p1 and p2
	  (define old-x1 (posn-x p1))
	  (define old-x2 (posn-x p2))
	  ;; modify both x fields of p1 and p2
	  (define effect1 (set-posn-x! p1 5))
	  (define effect2 (set-posn-x! p2 6))
	  ;; now compare the two fields
	  (define same (= (posn-x p1) (posn-x p2)))
	  ;; restore old values
	  (define effect3 (set-posn-x! p1 old-x1))
	  (define effect4 (set-posn-x! p2 old-x2)))
    same))



(require rackunit)
(require rackunit/text-ui)

(define intentional-equality-tests
  (test-suite
   "Test for intentional-equality"

   (check-false (eq-posn (make-posn 1 2) (make-posn 1 2)))
   (check-true (local ((define p (make-posn 1 2))) (eq-posn p p)))
   (check-true (local ((define p (make-posn 1 2))
                       (define a (list p)))
                      (eq-posn (first a) p)))
   ))


(exit (run-tests intentional-equality-tests))
