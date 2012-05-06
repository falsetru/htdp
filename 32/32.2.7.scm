(define-struct state (left boat-on-left right trail) #:transparent)
; state::  left, right: side / board-on-left: bool / trail: (listof side)

(define-struct side (m c) #:transparent)  ; m, c: number


(define MC 3)

(define (make-BOAT-LOADS n)
  (local ((define (mk m c)
            (cond [(> m n) empty]
                  [(> (+ m c) n) (mk (add1 m) 0)]
                  [else (cons (make-side m c)
                              (mk m (add1 c)))])))
         (mk 0 1)))

(define BOAT-LOADS (make-BOAT-LOADS 2))

(define (next-states initial)
  (map (lambda (boat-load) (next-state initial boat-load))
       BOAT-LOADS))

(define (next-state initial boat-load)
  (local ((define left-delta
            (cond [(state-boat-on-left initial) (inv-boat-load boat-load)]
                  [else boat-load]))
          (define right-delta (inv-boat-load left-delta)))
         (make-state (apply-boat-load (state-left initial) left-delta)
                     (not (state-boat-on-left initial))
                     (apply-boat-load (state-right initial) right-delta)
                     (cons boat-load (state-trail initial)))))

(define (inv-boat-load boat-load)
  (make-side (- (side-m boat-load))
             (- (side-c boat-load))))

(define (apply-boat-load x y)
  (make-side (+ (side-m x) (side-m y))
             (+ (side-c x) (side-c y))))

(define (next-states/all states)
  (foldr append empty (map next-states states)))


(define (valid-side? side)
  (or (= (side-m side) 0)
      (>= (side-m side) (side-c side) 0)))

(define (valid-state? state)
  (and (valid-side? (state-left state))
       (valid-side? (state-right state))))

; filter-valid-states: (listof state) -> (listof states)
(define (filter-valid-states states)
  (filter valid-state? states))


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

(define (mc-solution states)
  (local ((define ss (filter-valid-states states))
          (define result (filter-final-states ss)))
         (cond [(empty? ss) false]
               [(cons? result) (reverse (state-trail (first result)))]
               [else (mc-solution (next-states/all ss))])))

(require rackunit)
(require rackunit/text-ui)

(define mc-solution-tests
  (test-suite "Test for mc-solution"
   (check-equal?
     (mc-solution (list (make-state (make-side 3 3)
                                     true
                                     (make-side 0 0)
                                     empty)))
     (list (side 0 2)
           (side 0 1)
           (side 0 2)
           (side 0 1)
           (side 2 0)
           (side 1 1)
           (side 2 0)
           (side 0 1)
           (side 0 2)
           (side 0 1)
           (side 0 2)))
   ))

(exit (run-tests mc-solution-tests))
