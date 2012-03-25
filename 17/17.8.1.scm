(define (list=?1 a-list another-list)
  (cond
    [(and (empty? a-list) (empty? another-list)) true]
    [(and (cons? a-list) (empty? another-list)) false]
    [(and (empty? a-list) (cons? another-list)) false]
    [(and (cons? a-list) (cons? another-list))
     (and (= (first a-list) (first another-list))
          (list=?1 (rest a-list) (rest another-list)))]))

(define (list=?2 a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list)
     (and (cons? another-list)
          (and (= (first a-list) (first another-list))
               (list=?2 (rest a-list) (rest another-list))))]))

(require rackunit)
(require rackunit/text-ui)

(define list-equal-tests
  (test-suite "Test for list-equal"

   (test-case "list=? 1"
    (check-equal? (list=?1 '() '()) true)
    (check-equal? (list=?1 '() '(1)) false)
    (check-equal? (list=?1 '() '(1 2 3)) false)
    (check-equal? (list=?1 '(1) '(1)) true)
    (check-equal? (list=?1 '(1) '(2)) false)
    (check-equal? (list=?1 '(1) '()) false)
    (check-equal? (list=?1 '(1 2 3) '(1 2 3)) true)
    (check-equal? (list=?1 '(1 2 3) '()) false)
    (check-equal? (list=?1 '(1 2 3) '(2)) false)
    (check-equal? (list=?1 '(1 2 3) '(1 2 4)) false)
    (check-equal? (list=?1 '(1 2 3) '(1 2 4 5)) false))

   (test-case "list=? 2"
    (check-equal? (list=?2 '() '()) true)
    (check-equal? (list=?2 '() '(1)) false)
    (check-equal? (list=?2 '() '(1 2 3)) false)
    (check-equal? (list=?2 '(1) '(1)) true)
    (check-equal? (list=?2 '(1) '(2)) false)
    (check-equal? (list=?2 '(1) '()) false)
    (check-equal? (list=?2 '(1 2 3) '(1 2 3)) true)
    (check-equal? (list=?2 '(1 2 3) '()) false)
    (check-equal? (list=?2 '(1 2 3) '(2)) false)
    (check-equal? (list=?2 '(1 2 3) '(1 2 4)) false)
    (check-equal? (list=?2 '(1 2 3) '(1 2 4 5)) false))
   ))

(run-tests list-equal-tests)
