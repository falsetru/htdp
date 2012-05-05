(define-struct state (left boat-on-left right) #:transparent); left, right: side / board-on-left: bool
(define-struct side (m c) #:transparent)  ; m, c: number

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

(require rackunit)
(require rackunit/text-ui)

(define next-states-tests
  (test-suite
   "Test for next-states"

   (test-case "next-state"
    (check-equal? (next-state (make-state (make-side 3 2)
                                          true
                                          (make-side 0 1))
                              (make-side 1 1))
                  (make-state (make-side 2 1)
                              false
                              (make-side 1 2))))

   (test-case "next-states"
    (check-equal? (next-states (make-state (make-side 3 2)
                                          true
                                          (make-side 0 1)))
                  (list
                    (make-state (make-side 3 1) false (make-side 0 2))
                    (make-state (make-side 3 0) false (make-side 0 3))
                    (make-state (make-side 2 2) false (make-side 1 1))
                    (make-state (make-side 2 1) false (make-side 1 2))
                    (make-state (make-side 1 2) false (make-side 2 1))
                    )))

   (test-case "next-states/all"
    (check-equal? (next-states/all
                    (list
                      (make-state (make-side 3 2) true (make-side 0 1))
                      (make-state (make-side 3 1) true (make-side 0 2))))
                  (list
                    (make-state (make-side 3 1) false (make-side 0 2))
                    (make-state (make-side 3 0) false (make-side 0 3))
                    (make-state (make-side 2 2) false (make-side 1 1))
                    (make-state (make-side 2 1) false (make-side 1 2))
                    (make-state (make-side 1 2) false (make-side 2 1))
                    (make-state (make-side 3 0) false (make-side 0 3))
                    (make-state (make-side 3 -1) false (make-side 0 4))
                    (make-state (make-side 2 1) false (make-side 1 2))
                    (make-state (make-side 2 0) false (make-side 1 3))
                    (make-state (make-side 1 1) false (make-side 2 2))
                    )))

   ))

(exit (run-tests next-states-tests))
