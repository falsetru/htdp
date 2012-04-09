(require rackunit)
(require rackunit/text-ui)

(define build-list-tests
  (test-suite "Test for build-list"

   (test-case "1."
    (check-equal? (build-list 4 identity) '(0 1 2 3))
    (check-equal? (build-list 4 add1) '(1 2 3 4)))

   (test-case "2."
    (define (prepend0 n)
      (cond [(zero? n) (list 1)]
            [else (cons 0 (prepend0 (sub1 n)))]))
    (check-equal? (build-list 4 prepend0) (list '(1) '(0 1) '(0 0 1) '(0 0 0 1))))

   (test-case "3. evens"
    (define (evens n)
      (local ((define (n2_2 n)
              (+ (* n 2) 2)))
             (build-list n n2_2)))
    (check-equal? (evens 3) '(2 4 6)))

   (test-case "4. tabulate"
    (define (tabulate n f) (reverse (build-list (add1 n) f)))
    (check-equal? (tabulate 5 sqr) '(25 16 9 4 1 0)))

   (test-case "5. diagonal"
    (define (diagonal n)
      (local ((define (one-at i)
                (local ((define (one-zero j) (if (= i j) 1 0)))
                       (build-list n one-zero))))
      (build-list n one-at)))
    (check-equal? (diagonal 3)
                  '((1 0 0)
                    (0 1 0)
                    (0 0 1))))
   ))

(run-tests build-list-tests)
