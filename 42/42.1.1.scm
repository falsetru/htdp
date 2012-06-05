#lang racket

(require "../41/41.3.3.scm")

(define (equal-child? ft1 ft2)
  (cond [(false? ft1) (false? ft2)]
        [(false? ft2) false]
        [else
          (and (symbol=? (child-name ft1) (child-name ft2))
               (= (child-social ft1) (child-social ft2))
               (equal-child? (child-father ft1) (child-father ft2))
               (equal-child? (child-mother ft1) (child-mother ft2)))]))

(require rackunit)
(require rackunit/text-ui)

(define equal-child?-tests
  (test-suite
   "Test for equal-child?"

   (test-case
    ""
    (define Gustav-clone (make-child 'Gustav 1988 Fred Eva))
    (check-true (equal-child? Gustav Gustav-clone))
    (check-false (equal-child? Gustav Fred))
    )
   ))

(run-tests equal-child?-tests)

; 최대추상실행시간 (O(min (number-of-nodes ft1) (number-of-nodes ft2)))
