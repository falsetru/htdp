(load "16.3.1.scm")

;(define (find dir name)
;  (cond [(memq name (map file-name (dir-files dir)))
;         (list (dir-name dir))]
;        [(find-in-dirs (dir-dirs dir) name)
;         (cons (dir-name dir) (find-in-dirs (dir-dirs dir) name))]
;        [else false]))
;
;(define (find-in-dirs dirs name)
;  (foldr (lambda (a b) (or a b)) false (map (lambda (dir) (find dir name)) dirs)))

(define (find-all dir name)
  (append
    (cond [(memq name (map file-name (dir-files dir)))
           (list (list (dir-name dir)))]
          [else empty])
    (map (lambda (path) (cons (dir-name dir) path))
         (find-all-in-dirs (dir-dirs dir) name)))
)

(define (find-all-in-dirs dirs name)
  (foldr append empty (map (lambda (dir) (find-all dir name)) dirs)))

(define (find dir name)
  (let ((all (find-all dir name)))
    (if (empty? all)
      false
      (first all))))


(define empty-dir (make-dir 'empty empty empty))

(require rackunit)
(require rackunit/text-ui)

(define 16.3.4-extra-tests
  (test-suite
   "Test for 16.3.4-extra"

   (check-equal? (find empty-dir 'part3) false)
   (check-equal? (find TS 'no-such-file) false)
   (check-equal? (find Text 'part3) (list 'Text))
   (check-equal? (find TS 'part3) (list 'TS 'Text))
   (check-equal? (find TS 'read!) (list 'TS))


   (check-equal? (find-all empty-dir 'part3) empty)
   (check-equal? (find-all TS 'no-such-file) empty)
   (check-equal? (find-all Text 'part3) (list (list 'Text)))
   (check-equal? (find-all TS 'part3) (list (list 'TS 'Text)))
   (check-equal? (find-all TS 'read!) (list (list 'TS) (list 'TS 'Libs 'Docs)))
   ))

(exit
  (cond
    ((= (run-tests 16.3.4-extra-tests) 0))
    (else 1)))
