(load "16.3.1.scm")

(define (find? dir name)
  (cond [(memq name (map file-name (dir-files dir))) true]
        [else (find-in-dirs? (dir-dirs dir) name)]))

(define (find-in-dirs? dirs name)
  (foldr (lambda (a b) (or a b)) false (map (lambda (dir) (find? dir name)) dirs)))

(define empty-dir (make-dir 'empty empty empty))

(require rackunit)
(require rackunit/text-ui)

(define 16.3.4-tests
  (test-suite
   "Test for 16.3.4"

   (check-equal? (find? empty-dir 'part3) false)
   (check-equal? (find? TS 'no-such-file) false)
   (check-equal? (find? Text 'part3) true)
   (check-equal? (find? TS 'part3) true)
   (check-equal? (find? TS 'read!) true)
   ))

(exit
  (cond
    ((= (run-tests 16.3.4-tests) 0))
    (else 1)))


