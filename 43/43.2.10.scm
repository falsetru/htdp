#lang racket

(require "43.2.7.scm")

(define eq-node? eq?)

(define (route-exists? orig dest visited-list)
  (cond
    [(eq-node? orig dest) true]
    [(not (false? (memq orig visited-list))) false]
    [else (route-exists? (node-to orig) dest (cons orig visited-list))]))

(define (reachable-list orig visited-list)
  (cond [(not (false? (memq orig visited-list))) visited-list]
        [else (reachable-list (node-to orig) (cons orig visited-list))]))

(define (make-simple-graph symbolic-list)
  (local ((define the-graph (symbolic-graph-to-structures symbolic-list))
          (define (service-manager msg)
            (cond
              ; 1. adding nodes that are connected to already existing nodes (by name);
              [(symbol=? msg 'add)
               (lambda (name-from name-to)
                 (begin
                   (set! the-graph (cons (create-node name-from) the-graph))
                   (connect-nodes name-from name-to the-graph)))]

              ; 2. changing the connection of a node (by name);
              [(symbol=? msg 'change)
               (lambda (name-from name-to)
                 (set-node-to!
                   (lookup-node name-from the-graph)
                   (lookup-node name-to   the-graph)))]

              ; 3. determining whether a route between two nodes exists;
              [(symbol=? msg 'route-exists?)
               (lambda (orig dest)
                 (route-exists? (lookup-node orig the-graph) (lookup-node dest the-graph) empty))]

              ; 4. and removing nodes that are not reachable from some given node.
              [(symbol=? msg 'remove-unreachable)
               (lambda (orig)
                 (local ((define reachable (reachable-list (lookup-node orig the-graph) empty)))
                        (set! the-graph (filter (lambda (x) (not (false? (memq x reachable)))) the-graph))))]

              ; For test.
              [(symbol=? msg 'node-names)
               (map node-name the-graph)]

              [else (error 'make-simple-graph "message not understood")])))
         service-manager))

(require rackunit)
(require rackunit/text-ui)

(define make-simple-graph-tests
  (test-suite
   "Test for make-simple-graph-tests"

   (test-case
    ""
    (define sg (make-simple-graph empty))
    ((sg 'add) 'A 'A)
    ((sg 'add) 'B 'B)
    ((sg 'add) 'C 'C)
    ((sg 'add) 'D 'D)
    ((sg 'add) 'E 'E)
    ((sg 'add) 'F 'F)
    ((sg 'change) 'A 'B)
    ((sg 'change) 'B 'C)
    ((sg 'change) 'C 'E)
    ((sg 'change) 'D 'E)
    ((sg 'change) 'E 'B)

    (check-equal? ((sg 'route-exists?) 'A 'A) true)
    (check-equal? ((sg 'route-exists?) 'A 'B) true)
    (check-equal? ((sg 'route-exists?) 'A 'C) true)
    (check-equal? ((sg 'route-exists?) 'A 'D) false)
    (check-equal? ((sg 'route-exists?) 'A 'E) true)
    (check-equal? ((sg 'route-exists?) 'A 'F) false)

    (check-equal? ((sg 'route-exists?) 'F 'A) false)
    (check-equal? ((sg 'route-exists?) 'F 'B) false)
    (check-equal? ((sg 'route-exists?) 'F 'C) false)
    (check-equal? ((sg 'route-exists?) 'F 'D) false)
    (check-equal? ((sg 'route-exists?) 'F 'E) false)
    (check-equal? ((sg 'route-exists?) 'F 'F) true)

    ((sg 'remove-unreachable) 'D)

    (check-equal? (sg 'node-names) '(E D C B))
    )
   ))

(exit (run-tests make-simple-graph-tests))
