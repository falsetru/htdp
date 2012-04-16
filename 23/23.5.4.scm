(define (d/dx f)
  (local ((define (fprime x)
            (/ (- (f (+ x eps)) (f (- x eps)))
               (* 2 eps)))
          (define eps 1))
         fprime))

(require rackunit)
(require rackunit/text-ui)

(define d/dx-tests
  (test-suite "Test for d/dx"
   (test-case "x^2 - 4x + 7"
     (define (y x) (+ (* x x) (* -4 x) 7))
     (check-equal? ((d/dx y) 2) 0))
   ))

(exit (run-tests d/dx-tests))
