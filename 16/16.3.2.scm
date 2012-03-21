(load "16.3.1.scm")

(define file? symbol?)

(define (how-many dir)
  (+ (how-many-files-in-dirs (dir-dirs dir))
     (how-many-files (dir-files dir))))

(define (how-many-files-in-dirs dirs)
  (cond [(empty? dirs) 0]
        [else (+ (how-many (first dirs)) (how-many-files-in-dirs (rest dirs)))]))

(define (how-many-files files)
  (length files))

(define empty-dir (make-dir 'empty empty empty))

(require rackunit)
(require rackunit/text-ui)

(define 16.3.2-tests
  (test-suite
   "Test for 16.3.2"

   (check-equal? (how-many empty-dir) 0)
   (check-equal? (how-many Docs) 1)
   (check-equal? (how-many Text) 3)
   (check-equal? (how-many TS) 7)
   ))

(exit
  (cond
    ((= (run-tests 16.3.2-tests) 0))
    (else 1)))
