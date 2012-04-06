; tabulate:
;   number (number->number) -> (listof number)
; or
;   number (X->Y) -> (listof Y)

(define (tabulate n f)
  (cond [(= n 0) (list (f 0))]
        [else (cons (f n)
                    (tabulate (sub1 n) f))]))

(define (tabulate-sin n) (tabulate n sin))
(define (tabulate-sqrt n) (tabulate n sqrt))
(define (tabulate-sqr n) (tabulate n sqr))
(define (tabulate-tan n) (tabulate n tan))


(require rackunit)
(require rackunit/text-ui)

(define tabulate-tests
  (test-suite "Test for tabulate"
   (check-equal? (tabulate-sqr 5) '(25 16 9 4 1 0))
   ))

(run-tests tabulate-tests)
