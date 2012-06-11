#lang racket

(provide
  (struct-out node)
  create-node
  connect-nodes
  lookup-node
  eq-node?
  clear-visited

  the-graph
  )

(define-struct node (name visited to) #:mutable)
(define (create-node name)
  (local ((define the-node (make-node name false false)))
    (begin
      (set-node-to! the-node the-node)
      the-node)))
(define (connect-nodes from-name to-name a-graph)
  (set-node-to! (lookup-node from-name a-graph)
                (lookup-node to-name a-graph)))
(define (lookup-node x a-graph) 
  (first (memf (lambda (node) (symbol=? (node-name node) x)) a-graph)))

(define eq-node? eq?)

(define (clear-visited sg)
  (for-each (lambda (node) (set-node-visited! node false)) sg))

(define (route-exists? orig dest sg)
  (local ((define (route-exists?-aux orig dest)
            (cond
              [(eq-node? orig dest) true]
              [(node-visited orig) false]
              [else
                (begin
                  (set-node-visited! orig true)
                  (route-exists?-aux (node-to orig) dest))])))
         (begin
           (clear-visited sg)
           (route-exists?-aux orig dest))))

(define the-graph
  (list (create-node 'A)
        (create-node 'B)
        (create-node 'C)
        (create-node 'D)
        (create-node 'E)
        (create-node 'F)))

(begin
  (connect-nodes 'A 'B the-graph)
  (connect-nodes 'B 'C the-graph)
  (connect-nodes 'C 'E the-graph)
  (connect-nodes 'D 'E the-graph)
  (connect-nodes 'E 'B the-graph))


(require rackunit)
(require rackunit/text-ui)

(define route-exists?-tests
  (test-suite
   "Test for route-exists?"

   (test-case
    ""
    (check-equal? (route-exists? (lookup-node 'A the-graph)
                                 (lookup-node 'A the-graph)
                                 the-graph)
                  true)
    (check-equal? (route-exists? (lookup-node 'A the-graph)
                                 (lookup-node 'E the-graph)
                                 the-graph)
                  true)
    (check-equal? (route-exists? (lookup-node 'D the-graph)
                                 (lookup-node 'C the-graph)
                                 the-graph)
                  true)
    (check-equal? (route-exists? (lookup-node 'C the-graph)
                                 (lookup-node 'D the-graph)
                                 the-graph)
                  false)
    )
   ))

(run-tests route-exists?-tests)
