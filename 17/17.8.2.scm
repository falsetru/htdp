(define (list=? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [else
      (and (cons? another-list)
           (= (first a-list) (first another-list))
           (list=? (rest a-list) (rest another-list)))]))

(require rackunit)
(require rackunit/text-ui)

(define list-equal-tests
  (test-suite "Test for list-equal"

   (test-case "list=?"
    (check-equal? (list=? '() '()) true)
    (check-equal? (list=? '() '(1)) false)
    (check-equal? (list=? '() '(1 2 3)) false)
    (check-equal? (list=? '(1) '(1)) true)
    (check-equal? (list=? '(1) '(2)) false)
    (check-equal? (list=? '(1) '()) false)
    (check-equal? (list=? '(1 2 3) '(1 2 3)) true)
    (check-equal? (list=? '(1 2 3) '()) false)
    (check-equal? (list=? '(1 2 3) '(2)) false)
    (check-equal? (list=? '(1 2 3) '(1 2 4)) false)
    (check-equal? (list=? '(1 2 3) '(1 2 4 5)) false))
   ))

(run-tests list-equal-tests)
