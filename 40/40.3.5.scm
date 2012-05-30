#lang racket



(require rackunit)
(require rackunit/text-ui)

(define struct-modifying-tests
  (test-suite
   "Test for struct-modifying"

   (test-case
     ""
     (define-struct CD (artist title price) #:mutable #:transparent)
     (define in-stock
       (list
         (make-CD 'R.E.M "New Adventures in Hi-fi" 0)
         (make-CD 'France "simple je" 0)
         (make-CD 'Cranberries "no need to argue" 0)))
     (check-equal? 
       (begin
         (set-CD-price! (first in-stock) 12)
         (set-CD-price! (second in-stock) 19)
         (set-CD-price! (third in-stock) 11)
         (+ (CD-price (first in-stock))
            (CD-price (second in-stock))
            (CD-price (third in-stock))))
       42)
     (check-equal?
       in-stock
       (list
         (make-CD 'R.E.M "New Adventures in Hi-fi" 12)
         (make-CD 'France "simple je" 19)
         (make-CD 'Cranberries "no need to argue" 11)))
     )
   ))

(exit (run-tests struct-modifying-tests))
