#lang racket

(require "43.2.8.scm")

(define (reachable orig)
  (cond [(node-visited orig) (void)]
        [else
          (begin (set-node-visited! orig true)
                 (reachable (node-to orig)))]))


(require rackunit)
(require rackunit/text-ui)

(define reachable-tests
  (test-suite
   "Test for reachable"

   (test-case
    ""
    (reachable (lookup-node 'B the-graph))
    (check-equal? (node-visited (lookup-node 'B the-graph)) true)
    (check-equal? (node-visited (lookup-node 'C the-graph)) true)
    (check-equal? (node-visited (lookup-node 'E the-graph)) true)
    (check-equal? (node-visited (lookup-node 'A the-graph)) false)
    (check-equal? (node-visited (lookup-node 'D the-graph)) false)
    (check-equal? (node-visited (lookup-node 'F the-graph)) false)

    (clear-visited the-graph)
    (reachable (lookup-node 'F the-graph))
    (check-equal? (node-visited (lookup-node 'A the-graph)) false)
    (check-equal? (node-visited (lookup-node 'B the-graph)) false)
    (check-equal? (node-visited (lookup-node 'C the-graph)) false)
    (check-equal? (node-visited (lookup-node 'D the-graph)) false)
    (check-equal? (node-visited (lookup-node 'E the-graph)) false)
    (check-equal? (node-visited (lookup-node 'F the-graph)) true)
    )
   ))

(exit (run-tests reachable-tests))
