;; list-pick : list-of-symbols N[>= 1]  ->  symbol
;; to determine the nth symbol from alos, counting from 1;
;; signals an error if there is no nth item
(define (list-pick alos n)
  (cond
    [(and (= n 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (> n 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (= n 1) (cons? alos)) (first alos)]
    [(and (> n 1) (cons? alos)) (list-pick (rest alos) (sub1 n))]))

(define (test-list-pick lst n expected)
  (equal? (list-pick lst n) expected))

(require rackunit)
(require rackunit/text-ui)

(define test-list-pick-tests
  (test-suite
   "Test for test-list-pick"

   (check-equal? (test-list-pick '(a) 1 'a) true)
   (check-exn exn? (lambda () (test-list-pick '() 1 'a)))
   (check-exn exn? (lambda () (test-list-pick '() 3 'a)))
   (check-exn exn? (lambda () (test-list-pick '(a) 3 'a)))
   ))

(run-tests test-list-pick-tests)
