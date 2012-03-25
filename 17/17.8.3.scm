(define (sym-list=? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [else
      (and (cons? another-list)
           (symbol=? (first a-list) (first another-list))
           (sym-list=? (rest a-list) (rest another-list)))]))

(require rackunit)
(require rackunit/text-ui)

(define sym-list-equal-tests
  (test-suite "Test for sym-list-equal"

   (test-case "sym-list=?"
    (check-equal? (sym-list=? '() '()) true)
    (check-equal? (sym-list=? '() '(a)) false)
    (check-equal? (sym-list=? '() '(a b c)) false)
    (check-equal? (sym-list=? '(a) '(a)) true)
    (check-equal? (sym-list=? '(a) '(b)) false)
    (check-equal? (sym-list=? '(a) '()) false)
    (check-equal? (sym-list=? '(a b c) '(a b c)) true)
    (check-equal? (sym-list=? '(a b c) '()) false)
    (check-equal? (sym-list=? '(a b c) '(b)) false)
    (check-equal? (sym-list=? '(a b c) '(a b d)) false)
    (check-equal? (sym-list=? '(a b c) '(a b d e)) false))
   ))

(run-tests sym-list-equal-tests)
