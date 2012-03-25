(define (atom-equal? a b)
  (cond [(number? a) (and (number? b) (= a b))]
        [(boolean? a) (and (boolean? b) (boolean=? a b))]
        [(symbol? a) (and (symbol? b) (symbol=? a b))]
        [else false] ; XXX
        ))

(define (list-equal? a b)
  (cond [(empty? a) (empty? b)]
        [else (and (cons? b)
                   (atom-equal? (first a) (first b))
                   (list-equal? (rest a) (rest b)))]))

(require rackunit)
(require rackunit/text-ui)

(define list-equal-tests
  (test-suite "Test for list-equal"

   (check-equal? (list-equal? '() '()) true)
   (check-equal? (list-equal? '(1) '()) false)
   (check-equal? (list-equal? '(1) '(1)) true)
   (check-equal? (list-equal? '(1) '(2)) false)
   (check-equal? (list-equal? '(1) '(1 1)) false)
   (check-equal? (list-equal? '(#t) '(#t)) true)
   (check-equal? (list-equal? '(#f) '(#f)) true)
   (check-equal? (list-equal? '(#t) '(#f)) false)
   (check-equal? (list-equal? '(1) '(1 1)) false)
   (check-equal? (list-equal? '(x) '(x)) true)
   (check-equal? (list-equal? '(x y) '(x y)) true)
   (check-equal? (list-equal? '(x) '(x x)) false)
   (check-equal? (list-equal? '(1) '(#t)) false)
   (check-equal? (list-equal? '(a) '(#t)) false)
   (check-equal? (list-equal? '(#f) '(b)) false)))

(run-tests list-equal-tests)
