;; replace-eol-with : list-of-numbers list-of-numbers  ->  list-of-numbers
;; to construct a new list by replacing empty in alon1 with alon2
(define (replace-eol-with alon1 alon2)
  (cond
    ((empty? alon1) alon2)
    (else (cons (first alon1) (replace-eol-with (rest alon1) alon2)))))

(require rackunit)
(require rackunit/text-ui)

(define replace-eol-with-tests
  (test-suite
   "Test for replace-eol-with"

   (check-equal? (equal? (replace-eol-with '() '()) '()) true)
   (check-equal? (equal? (replace-eol-with '(a) '()) '(a)) true)
   (check-equal? (equal? (replace-eol-with '() '(a)) '(a)) true)
   (check-equal? (equal? (replace-eol-with '(a b) '(c d)) '(a b c d)) true)
   ))

(run-tests replace-eol-with-tests)
