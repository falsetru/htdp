#lang racket

(define addressbook '((Adam 1)
                      (Eve 2)
                      (Chris 6145384)))

(define (remove name)
  (set! addressbook (removed name addressbook)))

(define (removed name addressbook)
  (cond [(empty? addressbook) empty]
        [(symbol=? (first (first addressbook)) name) (rest addressbook)]
        [else (cons (first addressbook) (removed name (rest addressbook)))]))

(require rackunit)
(require rackunit/text-ui)

(define remove-tests
  (test-suite
   "Test for remove"

   (test-case
    "remove"
    (remove 'Eve)
    (check-equal? addressbook '((Adam 1)
                                (Chris 6145384)))
    )
   ))

(exit (run-tests remove-tests))
