(require rackunit)
(require rackunit/text-ui)

(define (d a b c)
  (- (sqr b) (* 4 a c)))

(define (quadratic-roots a b c)
  (cond [(= a 0) 'degenerate]
        [(> (d a b c) 0) (list (/ (- (- b) (sqrt (d a b c))) (* 2 a))
                               (/ (+ (- b) (sqrt (d a b c))) (* 2 a)))]
        [(= (d a b c) 0) (list (/ (- b) (* 2 a)))]
        [(< (d a b c) 0) 'none]))

(define 10.1.8-tests
  (test-suite
   "Test for 10.1.8"

   (check-equal? (quadratic-roots 0 0 1) 'degenerate)
   (check-equal? (quadratic-roots 1 0 -1) '(-1 1))
   (check-equal? (quadratic-roots 2 4 2) '(-1))
   (check-equal? (quadratic-roots 2 1 4) 'none)
   ))

(run-tests 10.1.8-tests)
