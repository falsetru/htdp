(load "16.3.1.scm")

(define file? symbol?)

(define (du-dir dir)
  (+ (du-dir-files-in-dirs (dir-dirs dir))
     (du-dir-files (dir-files dir))))

(define (du-dir-files-in-dirs dirs)
  (cond [(empty? dirs) 0]
        [else (+ (du-dir (first dirs)) (du-dir-files-in-dirs (rest dirs)))]))

(define (du-dir-files files)
  (foldr + 0 (map file-size files)))

(define (du-dir-2 dir)
  (+ (du-dir-files-in-dirs-2 (dir-dirs dir))
     (du-dir-files (dir-files dir))
     (length (dir-dirs dir))
     (length (dir-files dir))))

(define (du-dir-files-in-dirs-2 dirs)
  (cond [(empty? dirs) 0]
        [else (+ (du-dir-2 (first dirs)) (du-dir-files-in-dirs-2 (rest dirs)))]))


(define empty-dir (make-dir 'empty empty empty))

(require rackunit)
(require rackunit/text-ui)

(define 16.3.3-tests
  (test-suite
   "Test for 16.3.3"

   (check-equal? (du-dir empty-dir) 0)
   (check-equal? (du-dir Docs) 19)
   (check-equal? (du-dir Text) 168)
   (check-equal? (du-dir TS) 207)

   (check-equal? (du-dir-2 empty-dir) 0)
   (check-equal? (du-dir-2 Text) 171)
   (check-equal? (du-dir-2 Docs) 20)
   (check-equal? (du-dir-2 Code) 12)
   (check-equal? (du-dir-2 Libs) 34)
   (check-equal? (du-dir-2 TS) 218)
   ))

(exit
  (cond
    ((= (run-tests 16.3.3-tests) 0))
    (else 1)))

