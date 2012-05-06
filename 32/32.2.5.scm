(define-struct state (left boat-on-left right) #:transparent); left, right: side / board-on-left: bool
(define-struct side (m c) #:transparent)  ; m, c: number
(define MC 3)

(define (final-state? state)
  (and (= (side-m (state-left state))
          (side-c (state-left state))
          0)
       (= (side-m (state-right state))
          (side-c (state-right state))
          MC)
       (false? (state-boat-on-left state))))

(define (filter-final-states states)
  (filter final-state? states))

(require rackunit)
(require rackunit/text-ui)

(define final-state?-tests
  (test-suite
   "Test for final-state?"

   (check-equal?
     (final-state?
       (make-state (make-side 0 0) false (make-side 3 3)))
     true)

   (check-equal?
     (final-state?
       (make-state (make-side 0 2) false (make-side 3 1)))
     false)
   ))

(exit (run-tests final-state?-tests))
