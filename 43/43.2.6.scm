#lang racket

(define-struct node (name to) #:mutable)
(define (create-node name)
  (local ((define the-node (make-node name false)))
    (begin
      (set-node-to! the-node the-node)
      the-node)))

(define A (create-node 'A))
(define B (create-node 'B))
(define C (create-node 'C))
(define D (create-node 'D))
(define E (create-node 'E))
(define F (create-node 'F))
(begin
  (set-node-to! A B)
  (set-node-to! B C)
  (set-node-to! C E)
  (set-node-to! D E)
  (set-node-to! E B))
