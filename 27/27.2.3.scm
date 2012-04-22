(define-struct rr (table costs) #:transparent)

(define (line->rr line) (make-rr (first line) (rest line)))

(define (file->list-of-checks afile)
  (map line->rr
       (file->list-of-lines afile)))

(define (select-lines afile nl-found rest-lines)
  (cond
    [(empty? afile) empty]
    [else (cond
	    [(and (symbol? (first afile)) (symbol=? (first afile) NEWLINE)) (nl-found afile)]
	    [else (rest-lines afile)])]))

(define (first-line afile)
  (local ((define (rest-lines afile)
            (cons (first afile) (first-line (rest afile)))))
         (select-lines afile
                       (lambda (x) empty)
                       rest-lines)))

(define (remove-first-line afile)
  (local ((define (rest-lines afile) (remove-first-line (rest afile))))
         (select-lines afile
                       rest
                       rest-lines)))

(define (file->list-of-lines afile)
  (cond
    [(empty? afile) empty]
    [else
      (cons (first-line afile)
	    (file->list-of-lines (remove-first-line afile)))]))

(define NEWLINE 'NL)

(require rackunit)
(require rackunit/text-ui)

(define foo-tests
  (test-suite
   "Test for foo"

   (check-equal? (file->list-of-checks
                   (list 1 2.30 4.00 12.50 13.50 'NL
                         2 4.00 18.00 'NL
                         4 2.30 12.50))
                 (list (make-rr 1 (list 2.30 4.00 12.50 13.50))
                       (make-rr 2 (list 4.00 18.00))
                       (make-rr 4 (list 2.30 12.50))))
   ))

(exit (run-tests foo-tests))
