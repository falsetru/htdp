(load "16.2.1.scm")

(define (how-many dir)
  (cond [(empty? dir) 0]
        [(symbol? (first dir)) (+ 1 (how-many (rest dir)))]
        [else (+ (how-many (first dir)) (how-many (rest dir)))]))

(require rackunit)
(require rackunit/text-ui)

(define 16.2.2-tests
  (test-suite
   "Test for 16.2.2"

   (check-equal? (how-many empty) 0)
   (check-equal? (how-many Docs) 1)
   (check-equal? (how-many Text) 3)
   (check-equal? (how-many TS) 7)
   ))

(exit
  (cond
    ((= (run-tests 16.2.2-tests) 0))
    (else 1)))
