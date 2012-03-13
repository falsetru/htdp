(define (replace-eol-with alon1 alon2)
  (cond
    ((empty? alon1) alon2)
    (else (cons (first alon1) (replace-eol-with (rest alon1) alon2)))))

(define (my-append a b c)
  (replace-eol-with a (replace-eol-with b c)))

(require rackunit)
(require rackunit/text-ui)

(define 17.1.1-tests
  (test-suite
   "Test for 17.1.1"

   (check-equal? (my-append (list 'a) (list 'b 'c) (list 'd 'e 'f))
                 (list 'a 'b 'c 'd 'e 'f))

   (check-equal? 1 1)
   ))

(run-tests 17.1.1-tests)
