(require rackunit)
(require rackunit/text-ui)

(define (convert lon)
  (cond [(empty? lon) 0]
        [else (+ (first lon) (* 10 (convert (rest lon))))]))

(define (check-guess-for-list guess target)
  (cond [(< (convert guess) target) 'TooSmall]
        [(> (convert guess) target) 'TooLarge]
        [else 'Perfect]))

(define 9.5.5-tests
  (test-suite
   "Test for 9.5.5"

   (test-case
    "convert"
    (check-equal? (convert (list 4 3 2)) 234)
    )

   (test-case
    "check-guess-for-list"
    (check-equal? (check-guess-for-list '(3 2 1) 123) 'Perfect)
    (check-equal? (check-guess-for-list '(2 2 1) 123) 'TooSmall)
    (check-equal? (check-guess-for-list '(1) 123) 'TooSmall)
    (check-equal? (check-guess-for-list '(4 2 1) 123) 'TooLarge)
    (check-equal? (check-guess-for-list '(0 5 2 1) 123) 'TooLarge)
    )
   ))

(run-tests 9.5.5-tests)
