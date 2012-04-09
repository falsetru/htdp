(require rackunit)
(require rackunit/text-ui)

(define map-tests
  (test-suite "Test for map"

   (test-case "1. convert-euro"
    (define (convert-euro dollar-list)
      (local ((define (to-euro x) (* 1.22 x)))
             (map to-euro dollar-list)))
    (check-equal? (convert-euro '(1 2)) '(1.22 2.44)))

   (test-case "2. convert-fc"
    (define (convert-fc xs)
      (local ((define (farenheit->celcius x) (* (- x 32) (/ 5 9))))
             (map farenheit->celcius xs)))
    (check-equal? (convert-fc '(32 95)) '(0 35)))

   (test-case "3. move-all"
    (define-struct posn (x y))
    (define (move-all posn-list)
      (local ((define (move-x-3 p) (make-posn (+ 3 (posn-x p)) (posn-y p))))
             (map move-x-3 posn-list)))
    (define got (move-all (list (make-posn 1 2) (make-posn 3 3))))
    (define want (list (make-posn 4 2) (make-posn 6 3)))
    (check-equal? (posn-x (first got)) (posn-x (first want)))
    (check-equal? (posn-y (first got)) (posn-y (first want)))
    (check-equal? (posn-x (second got)) (posn-x (second want)))
    (check-equal? (posn-y (second got)) (posn-y (second want))))

   ))

(run-tests map-tests)
