#lang racket

(define-struct entry (name number) #:mutable)
(define (change-number! name phone ab)
  (cond
    [(empty? ab) (error 'change-number! "name not in list")]
    [else (cond
            [(symbol=? (entry-name (first ab)) name)
             (set-entry-number! (first ab) phone)]
            [else 
             (change-number! name phone (rest ab))])]))
(define (test-change-number)
  (local ((define ab (list
                       (make-entry 'Adam 1)
                       (make-entry 'Chris 3)
                       (make-entry 'Eve 2))))
         (begin
           (change-number! 'Chris 17 ab)
           (= (entry-number (second ab)) 17))))

(require rackunit)
(require rackunit/text-ui)

(define test-change-number-tests
  (test-suite
   "Test for test-change-number"

   (check-true (test-change-number))
   ))

(exit (run-tests test-change-number-tests))
