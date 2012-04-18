(define (generative-recursive-fun problem)
  (cond
    [(empty? problem) 0]
    [else (+ 1 (generative-recursive-fun (rest problem)))]))

(require rackunit)
(require rackunit/text-ui)

(define generative-recursive-fun-tests
  (test-suite "Test for generative-recursive-fun"

   (check-equal? (generative-recursive-fun '()) 0)
   (check-equal? (generative-recursive-fun '(1)) 1)
   ))

(exit (run-tests generative-recursive-fun-tests))
