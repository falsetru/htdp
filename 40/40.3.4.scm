#lang racket

(require rackunit)
(require rackunit/text-ui)

(define struct-modifying-tests
  (test-suite
   "Test for struct-modifying"

   (test-case
     ""
     (define-struct cheerleader (name number) #:mutable #:transparent)
     (define A (make-cheerleader 'JoAnn 2))
     (define B (make-cheerleader 'Belle 1))
     (define C (make-cheerleader 'Krissy 1)) 
     (define all (list A B C))
     (check-equal? 
       (list
         (cheerleader-number (second all))
         (begin
           (set-cheerleader-number! (second all) 17)
           (cheerleader-number (second all))))

       '(1 17))
     (check-equal? A (make-cheerleader 'JoAnn 2))
     (check-equal? B (make-cheerleader 'Belle 17))
     (check-equal? C (make-cheerleader 'Krissy 1))
     )
   ))

(exit (run-tests struct-modifying-tests))
