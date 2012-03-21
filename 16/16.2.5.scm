(load "16.2.4.scm")

(define file? symbol?)

(define (how-many dir)
  (how-many-helper (dir-content dir)))

(define (how-many-helper lofd)
  (cond [(empty? lofd) 0]
        [(file? (first lofd)) (+ 1 (how-many-helper (rest lofd)))]
        [else (+ (how-many (first lofd)) (how-many-helper (rest lofd)))]))

(define empty-dir (make-dir 'empty empty))

(require rackunit)
(require rackunit/text-ui)

(define 16.2.4-tests
  (test-suite
   "Test for 16.2.4"

   (check-equal? (how-many empty-dir) 0)
   (check-equal? (how-many Docs) 1)
   (check-equal? (how-many Text) 3)
   (check-equal? (how-many TS) 7)
   ))

(exit
  (cond
    ((= (run-tests 16.2.4-tests) 0))
    (else 1)))
