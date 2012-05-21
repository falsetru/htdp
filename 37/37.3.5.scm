#lang racket

(define visited-nodes empty)
(define (route-exists? orig dest sg)
  (cond
    [(cons? (memq orig visited-nodes)) false]
    [(symbol=? orig dest) true]
    [else
      (begin
        (set! visited-nodes (cons orig visited-nodes))
        (route-exists? (neighbor orig sg) dest sg))]))

(define (neighbor a-node sg)
  (cond
    [(empty? sg) (error "neighbor: impossible")]
    [else (cond
	    [(symbol=? (first (first sg)) a-node)
	     (second (first sg))]
	    [else (neighbor a-node (rest sg))])]))


(define SimpleG 
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F))) 

(require rackunit)
(require rackunit/text-ui)

(define route-exists?-tests
  (test-suite
   "Test for route-exists?"

   (check-equal? (route-exists? 'A 'C SimpleG) true)
   (check-equal? (route-exists? 'C 'D SimpleG) false)
   ))

(exit (run-tests route-exists?-tests))
