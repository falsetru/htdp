#lang racket

; XXX: drop name
(define-struct node (ssn left right) #:transparent #:mutable)

(define e empty)
(define (mk ssn) (make-node ssn e e))

; XXX: bst should contain at least 1 node.
(define (insert-bst-aux s bst parent setf)
  (cond [(empty? bst) (setf parent (mk s))]
        [(< s (node-ssn bst)) (insert-bst-aux s (node-left bst) bst set-node-left!)]
        [else (insert-bst-aux s (node-right bst) bst set-node-right!)]))

(define (insert-bst! s bst)
  (insert-bst-aux s bst e (lambda (parent setf) (error 'assert "no setf function given."))))

; XXX: bst should contain at least 2 nodes. will-be-removed node should not be root node.
(define (remove-bst-aux ssn bst parent setf)
  (cond [(empty? bst) (void)]
        [(< ssn (node-ssn bst)) (remove-bst-aux ssn (node-left bst) bst set-node-left!)]
        [(> ssn (node-ssn bst)) (remove-bst-aux ssn (node-right bst) bst set-node-right!)]

        ; = ssn (node-ssn bst)
        [(empty? (node-left bst)) (setf parent (node-right bst))]
        [(empty? (node-right bst)) (setf parent (node-left bst))]

        ; deleted node contained both left, right.
        [else
          (begin
            (setf parent (node-left bst))
            (for-each
              (lambda (n) (insert-bst! (node-ssn n) (node-left bst)))
              (bst->list (node-right bst))))
          ]))

(define (remove-bst! ssn bst)
  (remove-bst-aux ssn bst e (lambda (node x) (error 'assert "Can't remove root node.'"))))

(define (bst->list bst)
  (cond [(empty? bst) e]
        [else (cons bst
                    (append (bst->list (node-left bst))
                            (bst->list (node-right bst))))]))


(require rackunit)
(require rackunit/text-ui)

(define bst-tests
  (test-suite
   "Test for bst"

   (test-case "insert!"
    (define root (mk 5))
    (insert-bst! 3 root)
    (insert-bst! 1 root)
    (insert-bst! 4 root)
    (insert-bst! 6 root)
    (check-equal?
      root
      (make-node 5
        (make-node 3
          (mk 1)
          (mk 4))
        (mk 6)))
    )

   (test-case "remove!"
    (define bst1
      (make-node 5
        (make-node 3
          (mk 1)
          (mk 4))
        (mk 6)))
    (remove-bst! 3 bst1)
    (check-equal?
      bst1
      (make-node 5
        (make-node 1
          e
          (mk 4))
        (mk 6)))
    (remove-bst! 1 bst1)
    (check-equal?
      bst1
      (make-node 5
        (mk 4)
        (mk 6)))
    )
   ))

(exit (run-tests bst-tests))
