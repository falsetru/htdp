(define-struct ir (name price))

(define (filter1 rel-op alon t)
  (cond
    [(empty? alon) empty]
    [(rel-op (first alon) t)
     (cons (first alon)
           (filter1 rel-op (rest alon) t))]
    [else
      (filter1 rel-op (rest alon) t)]))

(define (filter-non-car xs)
  (filter1 ne-ir? xs 'car))
(define (ne-ir? ir t)
  (not (symbol=? (ir-name ir) t)))

(require rackunit)
(require rackunit/text-ui)

(define filter-non-car-tests
  (test-suite "Test for filter-non-car"

   (test-case ""
    (check-equal? (filter-non-car empty) empty)

    (define ir-list (list (make-ir 'car 10)
                          (make-ir 'toy 2)
                          (make-ir 'pc 6)
                          (make-ir 'car 11)))
    (define non-car-ir-list (filter-non-car ir-list))
    (check-equal? (length non-car-ir-list) 2)
    (check-equal? (ir-name (first non-car-ir-list)) 'toy)
    (check-equal? (ir-name (second non-car-ir-list)) 'pc)

    (check-equal? (filter-non-car (list (make-ir 'car 12)
                                        (make-ir 'car 11)))
                  empty)
    )
   ))

(run-tests filter-non-car-tests)
