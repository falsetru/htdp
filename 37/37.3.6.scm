#lang racket

(define-struct dir (name content))

(define Text (make-dir 'Text (list 'part1 'part2 'part3)))
(define Code (make-dir 'Code (list 'hang 'draw)))
(define Docs (make-dir 'Docs (list 'read!)))
(define Libs (make-dir 'Libs (list Code Docs)))
(define TS   (make-dir 'TS (list Text Libs 'read!)))

(define file? symbol?)


(define how-many-directories 0)
(define (dir-listing d)
  (begin
    (set! how-many-directories 0)
    (dir-listing-1 d)
    ))

(define (dir-listing-1 d)
  (begin
    (set! how-many-directories (add1 how-many-directories))
    (dir-listing-helper (dir-content d))))

(define (dir-listing-helper lofd)
  (cond [(empty? lofd) empty]
        [(file? (first lofd))
         (cons (first lofd)
               (dir-listing-helper (rest lofd)))]
        [else
          (begin
            (append (dir-listing-1 (first lofd))
                    (dir-listing-helper (rest lofd))))]))

(require rackunit)
(require rackunit/text-ui)

(define dir-listing-tests
  (test-suite
   "Test for dir-listing"

   (test-case "TS"
    (check-equal? (dir-listing TS) '(part1 part2 part3 hang draw read! read!))
    (check-equal? how-many-directories 5))

   (test-case "Docs"
    (check-equal? (dir-listing Docs) '(read!))
    (check-equal? how-many-directories 1)
    )
   ))

(exit (run-tests dir-listing-tests))
