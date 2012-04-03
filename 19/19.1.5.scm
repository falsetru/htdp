(define (find1 alon rel-op)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
            [(rel-op (first alon) 
                     (find1 (rest alon) rel-op))
             (first alon)]
            [else
              (find1 (rest alon) rel-op)])]))

(define (min1 alon) (find1 alon <))
(define (max1 alon) (find1 alon >))

(define (find2 alon rel-op)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (local ((define recur-result (find2 (rest alon) rel-op))
                  (define (pick-interesting a b)
                    (cond
                      [(rel-op a b) a]
                      [else b])))
                 (pick-interesting (first alon) recur-result)
                 )]))

(define (min2 alon) (find2 alon <))
(define (max2 alon) (find2 alon >))


(require rackunit)
(require rackunit/text-ui)

(define abstracted-function-tests
  (test-suite "Test for abstracted-function"

   (test-case "without local"
    (define a (list 3 7 6 2 9 8))
    (define b (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
    (define c (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

    (check-equal? (min1 a) 2)
    (check-equal? (min1 b) 1)
    (check-equal? (min1 c) 1)
    (check-equal? (max1 a) 9)
    (check-equal? (max1 b) 20)
    (check-equal? (max1 c) 20)
    )

   (test-case "with local"
    (define a (list 3 7 6 2 9 8))
    (define b (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
    (define c (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

    (check-equal? (min2 a) 2)
    (check-equal? (min2 b) 1)
    (check-equal? (min2 c) 1)
    (check-equal? (max2 a) 9)
    (check-equal? (max2 b) 20)
    (check-equal? (max2 c) 20)
    )
   ))

(run-tests abstracted-function-tests)
