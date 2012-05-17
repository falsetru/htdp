#lang racket

(provide
  make-status-word)

(define (make-status-word word)
  (map (lambda (c) '_) word))

(require rackunit)
(require rackunit/text-ui)

(define make-status-word-tests
  (test-suite
   "Test for make-status-word"

   (check-equal? (make-status-word '(h e l l o ))'(_ _ _ _ _))
   ))

(run-tests make-status-word-tests)
