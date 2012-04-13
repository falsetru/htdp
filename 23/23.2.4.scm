(define (a-fives-closed i)
  (+ (+ 3 5) (* 5 i)))

(define (seq-a-fives n)
  (build-list n a-fives-closed))

(require rackunit)
(require rackunit/text-ui)

(define seq-a-fives-tests
  (test-suite "Test for seq-a-fives"
   (check-equal? (seq-a-fives 3) '(8 13 18))
   ))

(run-tests seq-a-fives-tests)
