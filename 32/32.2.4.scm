(define-struct state (left boat-on-left right) #:transparent); left, right: side / board-on-left: bool
(define-struct side (m c) #:transparent)  ; m, c: number

(define (valid-side? side)
  (or (= (side-m side) 0)
      (>= (side-m side) (side-c side) 0)))

(define (valid-state? state)
  (and (valid-side? (state-left state))
       (valid-side? (state-right state))))

(define (filter-valid-states states)
  (filter valid-state? states))

(require rackunit)
(require rackunit/text-ui)

(define valid-state-tests
  (test-suite "Test for valid-state"

   (test-case "valid-side?"
    (check-equal? (valid-side? (make-side 0 0)) true)
    (check-equal? (valid-side? (make-side 3 0)) true)
    (check-equal? (valid-side? (make-side 3 2)) true)
    (check-equal? (valid-side? (make-side 3 3)) true)
    (check-equal? (valid-side? (make-side 2 3)) false)
    (check-equal? (valid-side? (make-side 2 -1)) false))

   (test-case "valid-state?"
    (check-equal?
      (valid-state?
        (make-state (make-side 2 2) false (make-side 1 1)))
      true)

    (check-equal?
      (valid-state?
        (make-state (make-side 1 2) false (make-side 2 1)))
      false)

    (check-equal?
      (valid-state?
        (make-state (make-side 3 1) false (make-side 0 2)))
      true)
    )

   (test-case "filter-valid-states"
    (check-equal?
      (filter-valid-states
        (list
          (make-state (make-side 2 2) false (make-side 1 1))
          (make-state (make-side 1 2) false (make-side 2 1))
          (make-state (make-side 3 1) false (make-side 0 2))))
      (list
        (make-state (make-side 2 2) false (make-side 1 1))
        (make-state (make-side 3 1) false (make-side 0 2)))))
   ))

(exit (run-tests valid-state-tests))
