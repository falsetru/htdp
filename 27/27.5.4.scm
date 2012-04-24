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
         (list a b2 c3)))

(require rackunit)
(require rackunit/text-ui)

(define triangulate-tests
  (test-suite
   "Test for triangulate"

   (check-equal? (multiply '(-3 -8 -19) -1)
                 '(3 8 19))

   (check-equal? (triangulate '((2 2 3 10)
                                (2 5 12 31)
                                (4 1 -2 1)))
                 '((2 2 3 10)
                   (  3 9 21)
                   (    1  2)))
   ))

(exit (run-tests triangulate-tests))
