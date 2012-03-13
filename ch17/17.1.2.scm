(require rackunit)
(require rackunit/text-ui)

(define (cross xs ys)
  (cond [(empty? xs) empty]
        [else (append (cross-1 (first xs) ys) (cross (rest xs) ys))]))

(define (cross-1 x ys)
  (cond [(empty? ys) empty]
        [else (cons (list x (first ys)) (cross-1 x (rest ys)))]))

(define 17.1.2-tests
  (test-suite
   "Test for 17.1.2"

   (check-equal? (cross-1 'x '(1 2 3))
                 '((x 1) (x 2) (x 3)))

   (check-equal? (cross '() '(1 2 3))
                 '())

   (check-equal? (cross '(a b) '(1 2 3))
                 '((a 1) (a 2) (a 3) (b 1) (b 2) (b 3)))
   ))

(run-tests 17.1.2-tests)
