(define-struct state (left boat-on-left right) #:transparent); left, right: side / board-on-left: bool
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
            (cond [state-boat-on-left (inv-boat-load boat-load)]
                  [else boat-load]))
          (define right-delta (inv-boat-load left-delta)))
         (make-state (apply-boat-load (state-left initial) left-delta)
                     (not (state-boat-on-left initial))
                     (apply-boat-load (state-right initial) right-delta))))

(define (inv-boat-load boat-load)
  (make-side (- (side-m boat-load))
             (- (side-c boat-load))))

(define (apply-boat-load x y)
  (make-side (+ (side-m x) (side-m y))
             (+ (side-c x) (side-c y))))

(define (next-states/all states)
  (foldr append empty (map next-states states)))


(define (valid-side? side)
  (>= (side-m side) (side-c side) 0))

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

(define (mc-solvable? states)
  (local ((define ss (filter-valid-states states)))
         (cond [(empty? ss) false]
               [(cons? (filter-final-states ss)) true]
               [else (mc-solvable? (next-states/all ss))])))

(require rackunit)
(require rackunit/text-ui)

(define mc-solvable?-tests
  (test-suite
   "Test for mc-solvable?"

   (check-equal?
     (mc-solvable? (list (make-state (make-side 0 0)
                                     false
                                     (make-side 3 3))))
     true)

   (check-equal?
     (mc-solvable? (list (make-state (make-side 1 1)
                                     true
                                     (make-side 2 2))))
     true)

   (check-equal?
     (mc-solvable? (list (make-state (make-side 3 3)
                                     true
                                     (make-side 0 0))))
     true)

   (check-equal?
     (mc-solvable? (list (make-state (make-side 4 3)
                                     true
                                     (make-side 0 0))))
     false)

   (check-equal?
     (mc-solvable? (list (make-state (make-side 1 3)
                                     true
                                     (make-side 0 0))))
     false)
   ))

(exit (run-tests mc-solvable?-tests))
