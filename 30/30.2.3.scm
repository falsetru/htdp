
(define SimpleG 
  #(1
    2
    4
    4
    1
    5)) 

(define (contains x xs)
  (cons? (memq x xs)))

(define (neighbor a-node sg)
  (cond
    [(>= a-node (vector-length sg)) (error "neighbor: impossible")]
    [else (vector-ref sg a-node)]))

(define (route-exists2? orig dest sg)
  (local ((define (re-accu? orig accu-seen)
            (cond
              [(= orig dest) true]
              [(contains orig accu-seen) false]
              [else (re-accu? (neighbor orig sg) (cons orig accu-seen))]))) 
    (re-accu? orig empty)))


(require rackunit)
(require rackunit/text-ui)

(define route-exists2?-tests
  (test-suite
   "Test for route-exists2?"

   (check-equal? (route-exists2? 0 2 SimpleG) true)
   (check-equal? (route-exists2? 2 3 SimpleG) false)
   ))

(exit (run-tests route-exists2?-tests))
