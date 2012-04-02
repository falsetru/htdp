(define-struct ir (name price))

(define (extract1 an-inv)
  (cond
    [(empty? an-inv) empty]
    [else (local ((define f (first an-inv))
                  (define r (rest an-inv)))
                 (cond [(<= (ir-price f) 1.00) (cons f (extract1 r))]
                       [else (extract1 r)]))]))


(require rackunit)
(require rackunit/text-ui)

(define extract1-tests
  (test-suite "Test for extract1"

   (test-case ""
    (define i
      (extract1 (list (make-ir 'keyboard 0.5)
                      (make-ir 'mouse 0.2)
                      (make-ir 'monitor 2.5)
                      (make-ir 'processor 1.9)
                      (make-ir 'disk 0.9))))
    (check-equal? (length i) 3)
    (check-equal? (ir-name (first i)) 'keyboard)
    (check-equal? (ir-name (second i)) 'mouse)
    (check-equal? (ir-name (third i)) 'disk)
    )
   ))

(run-tests extract1-tests)
