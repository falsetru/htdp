(define SimpleG 
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F))) 

(define (contains x xs)
  (cons? (memq x xs)))

(define (neighbor a-node sg)
  (cond
    [(empty? sg) (error "neighbor: impossible")]
    [else (cond
	    [(symbol=? (first (first sg)) a-node)
	     (second (first sg))]
	    [else (neighbor a-node (rest sg))])]))

(define (route-exists2? orig dest sg)
  (local ((define (re-accu? orig accu-seen)
            (cond
              [(symbol=? orig dest) true]
              [(contains orig accu-seen) false]
              [else (re-accu? (neighbor orig sg) (cons orig accu-seen))]))) 
    (re-accu? orig empty)))


(require rackunit)
(require rackunit/text-ui)

(define foo-tests
  (test-suite
   "Test for foo"

   (check-equal? (route-exists2? 'A 'C SimpleG) true)
   (check-equal? (route-exists2? 'C 'D SimpleG) false)
   ))

(exit (run-tests foo-tests))
