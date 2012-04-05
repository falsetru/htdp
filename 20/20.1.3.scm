(define (a-function=? fa fb)
  (and (equal? (fa 1.2) (fb 1.2))
       (equal? (fa 3) (fb 3))
       (equal? (fa -5.7) (fb -5.7))))

(require rackunit)
(require rackunit/text-ui)

(define a-function=?-tests
  (test-suite "Test for a-function=?"

   (test-case ""
    (define (plus_x_10 x) (+ x 10))
    (define (plus_10_x x) (+ 10 x))
    (define (mul_10_x x) (* 10 x))
    (check-equal? (a-function=? plus_x_10 plus_10_x) true)
    (check-equal? (a-function=? plus_x_10 mul_10_x) false)
    )
   ))

(run-tests a-function=?-tests)
