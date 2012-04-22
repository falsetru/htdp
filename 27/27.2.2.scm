(define (select-lines afile nl-found rest-lines)
  (cond
    [(empty? afile) empty]
    [else (cond
	    [(symbol=? (first afile) NEWLINE) (nl-found afile)]
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

(define file->list-of-lines-tests
  (test-suite
   "Test for file->list-of-lines"

   (check-equal?
     (file->list-of-lines (list 'a 'b 'c 'NL 'd 'e 'NL 'f 'g 'h 'NL))
     '((a b c)
       (d e)
       (f g h)))
   (check-equal?  (file->list-of-lines '(a)) '((a)))
   (check-equal?  (file->list-of-lines empty) empty)
   (check-equal?  (file->list-of-lines '(NL)) '(()))
   (check-equal?  (file->list-of-lines '(NL NL)) '(() ()))
   ))

(exit (run-tests file->list-of-lines-tests))
