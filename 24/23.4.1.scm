(define (integrate-kepler f left right)
  (local ((define (area-of-shape x1 x2 y1 y2)
            (* (- x2 x1) (/ (+ y1 y2) 2)))
          (define center (/ (+ left right) 2))
          (define area1 (area-of-shape left center (f left) (f center)))
          (define area2 (area-of-shape center right (f center) (f right))))
         (+ area1 area2)))

(require rackunit)
(require rackunit/text-ui)

(define integrate-kepler-tests
  (test-suite "Test for integrate-kepler"
   (test-case "y = x"
    (define (y x) x)
    (check-equal? (integrate-kepler y 0 4) 8)
    (check-equal? (integrate-kepler y -2 2) 0))
   ))

(exit (run-tests integrate-kepler-tests))
