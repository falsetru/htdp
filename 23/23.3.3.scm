(define (g-fives-closed i)
  (* 3 (expt 5 i)))

(define (seq-g-fives n)
  (build-list n g-fives-closed))

(require rackunit)
(require rackunit/text-ui)

(define seq-g-fives-tests
  (test-suite "Test for seq-g-fives"
   (check-equal? (seq-g-fives 3) '(3 15 75))
   ))

(exit (run-tests seq-g-fives-tests))
