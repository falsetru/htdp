(define-struct posn (x y))
(define p make-posn)

(define (threatened? p1 p2)
  (or (= (posn-x p1) (posn-x p2))
      (= (posn-y p1) (posn-y p2))
      (= (- (posn-x p1) (posn-y p1))
         (- (posn-x p2) (posn-y p2)))
      (= (+ (posn-x p1) (posn-y p1))
         (+ (posn-x p2) (posn-y p2)))))

(require rackunit)
(require rackunit/text-ui)

(define threatened?-tests
  (test-suite
   "Test for threatened?"

   (check-true  (threatened? (p 3 2) (p 3 7)))
   (check-false (threatened? (p 3 1) (p 2 7)))
   (check-true  (threatened? (p 2 2) (p 5 2)))
   (check-false (threatened? (p 2 2) (p 3 7)))
   (check-true  (threatened? (p 0 0) (p 1 1)))
   (check-true  (threatened? (p 1 4) (p 2 5)))
   (check-true  (threatened? (p 1 4) (p 3 6)))
   (check-true  (threatened? (p 2 3) (p 1 4)))
   (check-true  (threatened? (p 2 3) (p 0 5)))
   (check-true  (threatened? (p 2 3) (p 3 2)))
   (check-true  (threatened? (p 2 3) (p 4 1)))
   ))

(exit (run-tests threatened?-tests))
