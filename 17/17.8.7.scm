(define-struct posn (x y))

(define (posn=? a b)
  (and (= (posn-x a) (posn-x b))
       (= (posn-y a) (posn-y b))))

(require rackunit)
(require rackunit/text-ui)

(define posn-equal-tests
  (test-suite
   "Test for posn-equal"

   (check-equal? (posn=? (make-posn 1 2) (make-posn 1 2)) true)
   (check-equal? (posn=? (make-posn 2 2) (make-posn 2 1)) false)
   ))

(run-tests posn-equal-tests)
