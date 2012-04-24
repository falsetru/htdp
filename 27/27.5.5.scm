(define (multiply lst x)
  (map (lambda (y) (* x y)) lst))

(define (sub a b)
  (cond [(empty? a) empty]
        [else (cons (- (first b) (first a))
                    (sub (rest a) (rest b)))]))

(define (substract a b)
  (cond [(empty? a) empty]
        [else
          (local ((define a-prime (multiply a (/ (first b) (first a)))))
                 (rest (sub a-prime b)))]))

(define (triangulate eqs)
  (local ((define a (first eqs))
          (define b (second eqs))
          (define c (third eqs))
          (define b2 (substract a b))
          (define c2 (substract a c))
          (define c3 (substract c2 b2)))
         (cond [(zero? (first b2)) (list a c2 (rest b2))]
               [else (list a b2 c3)])))

(require rackunit)
(require rackunit/text-ui)

(define triangulate-revised-tests
  (test-suite
   "Test for triangulate-revised"

   (check-equal? (triangulate '((2 3 3 8)
                                (2 3 -2 3)
                                (4 -2 2 4)))
                 '((2 3  3   8)
                   ( -8 -4 -12)
                   (    -5  -5)))
   ))

(exit (run-tests triangulate-revised-tests))
