#lang racket

(define-struct node (name to) #:mutable #:transparent)

(define (create-node name)
  (local ((define the-node (make-node name false)))
    (begin
      (set-node-to! the-node the-node)
      the-node)))

;; connect-nodes : symbol symbol graph  ->  void
;; effect: to mutate the to field in the structure named 
;; from-name so that it contains the structure named to-name
(define (connect-nodes from-name to-name a-graph)
  (set-node-to! (lookup-node from-name a-graph)
                (lookup-node to-name a-graph)))

;; lookup-node : symbol graph  ->  node or false
;; to lookup up the node named x in a-graph
(define (lookup-node x a-graph) 
  (first (memf (lambda (node) (symbol=? (node-name node) x)) a-graph)))

;; the-graph : graph
;; the list of all available nodes 
(define the-graph
  (list (create-node 'A)
        (create-node 'B)
        (create-node 'C)
        (create-node 'D)
        (create-node 'E)
        (create-node 'F)))

;; setting up the graph: 
(begin
  (connect-nodes 'A 'B the-graph)
  (connect-nodes 'B 'C the-graph)
  (connect-nodes 'C 'E the-graph)
  (connect-nodes 'D 'E the-graph)
  (connect-nodes 'E 'B the-graph))


(define (symbolic-graph-to-structures symbolic-list)
  (local ((define the-graph
            (map
              (lambda (assc)
                (create-node (first assc)))
              symbolic-list)))
         (begin
           (for-each
             (lambda (assc)
               (connect-nodes (first assc) (second assc) the-graph))
             symbolic-list)
           the-graph
           )))


(require rackunit)
(require rackunit/text-ui)

(define symbolic-graph-to-structures-tests
  (test-suite "Test for symbolic-graph-to-structures"

   (check-equal?
     (symbolic-graph-to-structures '((A B) (B C) (C E) (D E) (E B) (F F)))
     the-graph)
   ))

(exit (run-tests symbolic-graph-to-structures-tests))
