(define TOLERANCE 0.5)

(define (integrate-dc-1 f left right)
  (local ((define m (/ (+ left right) 2)))
         (cond [(<= (- right left) TOLERANCE)
                (* (- right left) (f m))]
               [else (+ (integrate-dc-1 f left m)
                        (integrate-dc-1 f m right))])))

(define (integrate-dc-2 f left right)
  (local ((define m (/ (+ left right) 2)))
         (cond [(<= (- right left) TOLERANCE)
                (trapezoid-area left right (f left) (f right))]
               [else (+ (integrate-dc-2 f left m)
                        (integrate-dc-2 f m right))])))

(define (trapezoid-area left right f-left f-right)
  (* (- right left)
     (/ (+ f-right f-left) 2)))

(define TOLERANCE2 0.001)
(define (integrate-dc-3 f left right)
  (local ((define m (/ (+ left right) 2))
          (define area (trapezoid-area left right (f left) (f right))))
         (cond [(or (<= area (* TOLERANCE (- right left)))
                    (<= (- right left) TOLERANCE2))
                area]
               [else (+ (integrate-dc-3 f left m)
                        (integrate-dc-3 f m right))])))


(require rackunit)
(require rackunit/text-ui)

(define integrate-dc-tests
  (test-suite
   "Test for integrate-dc"

   (test-case
    "integrate-dc"
    (define (f x) x)

    (check-equal? (integrate-dc-1 f 0 10) 50)
    (check-equal? (integrate-dc-2 f 0 10) 50)
    (check-equal? (integrate-dc-3 f 0 10) 50)
    )
   ))

(exit (run-tests integrate-dc-tests))
