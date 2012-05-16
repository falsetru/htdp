#lang racket

(require rackunit)
(require rackunit/text-ui)

(define make-status-word-tests
  (test-suite
   "Test for make-status-word"

   (test-case
    "status-word using build-list"
    (define word '(h e l l o))
    (define status-word (build-list (length word) (lambda (c) '_)))
    (check-equal? status-word '(_ _ _ _ _))
    )
   ))

(exit (run-tests make-status-word-tests))
