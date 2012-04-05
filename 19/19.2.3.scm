(define-struct pair (left right))

(define (lefts xs)
  (cond [(empty? xs) empty]
        [else (cons (pair-left (first xs))
                    (lefts (rest xs)))]))

(require rackunit)
(require rackunit/text-ui)

(define lefts-tests
  (test-suite
   "Test for lefts"

   (check-equal? (lefts empty) empty)
   (check-equal? (lefts (list (make-pair 1 2))) (list 1))
   (check-equal? (lefts (list (make-pair 1 2) (make-pair 3 4))) (list 1 3))
   ))

(run-tests lefts-tests)
