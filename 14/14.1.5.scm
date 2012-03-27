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

(define (eye-colors c)
  (cond [(empty? c) empty]
        [else (append
                (list (child-eyes c))
                (eye-colors (child-father c))
                (eye-colors (child-mother c)))]))

(require rackunit)
(require rackunit/text-ui)

(define count-persons-tests
  (test-suite
   "Test for count-persons"

   (check-equal? (eye-colors Carl) '(green))
   (check-equal? (eye-colors Gustav) '(brown pink blue green green))
   ))

(run-tests count-persons-tests)
