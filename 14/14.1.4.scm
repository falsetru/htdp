 (define-struct child (father mother name date eyes))

 ;; Oldest Generation:
(define Carl (make-child empty empty 'Carl 1926 'green))
(define Bettina (make-child empty empty 'Bettina 1926 'green))

;; Middle Generation:
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest Generation: 
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))

(define (count-persons c)
  (cond [(empty? c) 0]
        [else (+ 1
                 (count-persons (child-father c))
                 (count-persons (child-mother c)))]))

(define (total-age c year)
  (cond [(empty? c) 0]
        [else (+ (if (> year (child-date c)) (- year (child-date c)) 0)
                 (total-age (child-father c) year)
                 (total-age (child-mother c) year))]))

(define (average-age c year)
  (/ (total-age c year) (count-persons c)))

(require rackunit)
(require rackunit/text-ui)

(define count-persons-tests
  (test-suite
   "Test for count-persons"

   (check-equal? (average-age Gustav 1800) 0)
   (check-equal? (average-age Gustav 2000) 229/5)
   ))

(run-tests count-persons-tests)
