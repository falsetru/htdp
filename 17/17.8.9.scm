(define (slist=? a b)
  (cond [(empty? a) (empty? b)]
        [else (and (cons? b)
                   (sexpr=? (first a) (first b))
                   (slist=? (rest a) (rest b)))]))

(define (sexpr=? a b)
  (cond [(number? a) (and (number? b) (= a b))]
        [(symbol? a) (and (symbol? b) (symbol=? a b))]
        [(boolean? a) (and (boolean? b) (boolean=? a b))]
        [else (slist=? a b)]))

(require rackunit)
(require rackunit/text-ui)

(define slit-equal-tests
  (test-suite
    "Test for slit-equal"

    (check-equal? (slist=? empty empty) true)
    (check-equal? (slist=? '(a 1) '(a 1)) true)
    (check-equal? (slist=? '(a #t 1) '(a #t 1)) true)
    (check-equal? (slist=? '(a #t (a b c) 1) '(a #t (a b c) 1)) true)
    (check-equal? (slist=? '(a #t (a (a 2 3) b c) 1) '(a #t (a (a 2 3) b c) 1)) true)

    (check-equal? (slist=? '(a 1) '()) false)
    (check-equal? (slist=? '() '(a 1)) false)
    (check-equal? (slist=? '(a 2) '(a 1)) false)
    (check-equal? (slist=? '(a 1) '(a #t 1)) false)
    (check-equal? (slist=? '(a #t 1) '(a #t)) false)
    (check-equal? (slist=? '(a #t 1) '(a #f 1)) false)
    (check-equal? (slist=? '(a #t 1) '(a #t 1 (1 2 3 (4 5 6)))) false)
    (check-equal? (slist=? '(a #t (a b c) 1) '(a #t (a x c) 1)) false)
   ))

(run-tests slit-equal-tests)
