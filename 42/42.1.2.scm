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

(define (is-ft? ft)
  (or (false? ft)
      (child? ft)))

(define-struct posn (x y))
(define (equal-posn p1 p2)
  (and (= (posn-x p1) (posn-x p2))
       (= (posn-y p1) (posn-y p2))))

(define (equal-abstract f-is? f-eq)
  (local ((define (eq x1 x2)
            (and (f-is? x1)
                 (f-is? x2)
                 (f-eq x1 x2))))
         eq))

(require rackunit)
(require rackunit/text-ui)

(define equal-child?-tests
  (test-suite
   "Test for equal-child?"

   (test-case
    ""
    (define Gustav-clone (make-child 'Gustav 1988 Fred Eva))
    (check-true ((equal-abstract child? equal-child?) Gustav Gustav-clone))
    (check-false ((equal-abstract child? equal-child?) Gustav Fred))

    (define p1 (make-posn 1 2))
    (define p2 (make-posn 3 4))
    (define p3 (make-posn 1 (add1 1)))
    (check-true ((equal-abstract posn? equal-posn) p1 p3))
    (check-false ((equal-abstract posn? equal-posn) p1 p2))

    ;; test for different structs.
    (check-false ((equal-abstract posn? equal-posn) Gustav p2))
    )
   ))

(exit (run-tests equal-child?-tests))

; 최대추상실행시간 (O(min (number-of-nodes ft1) (number-of-nodes ft2)))
