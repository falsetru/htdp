(require rackunit)
(require rackunit/text-ui)

(define lambda-expression-tests
  (test-suite "Test for lambda-expression"

    (check-equal?
      ((lambda (x y)
         (+ x (* x y)))
       1 2)
      3)

    (check-equal?
      ((lambda (x y)
         (+ x
            (local ((define x (* y y)))
                   (+ (* 3 x)
                      (/ 1 x)))))
       1 2)
      (+ 13 (/ 1 4))
      )

    (check-equal?
      ((lambda (x y)
         (+ x
            ((lambda (x)
               (+ (* 3 x)
                  (/ 1 x)))
             (* y y))))
       1 2)
      (+ 13 (/ 1 4))
      )
    ))

(exit (run-tests lambda-expression-tests))
