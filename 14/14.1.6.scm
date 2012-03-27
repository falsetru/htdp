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

(define (proper-blue-eyed-ancestor? c)
  (cond [(empty? c) false]
        [else (or (and (child? (child-father c)) (symbol=? (child-eyes (child-father c)) 'blue))
                  (and (child? (child-mother c)) (symbol=? (child-eyes (child-mother c)) 'blue))
                  (proper-blue-eyed-ancestor? (child-father c))
                  (proper-blue-eyed-ancestor? (child-mother c)))]))

(require rackunit)
(require rackunit/text-ui)

(define proper-blue-eyed-ancestor-tests
  (test-suite
   "Test for proper-blue-eyed-ancestor?"

   (check-equal? (proper-blue-eyed-ancestor? Eva) false)
   (check-equal? (proper-blue-eyed-ancestor? Gustav) true)
   ))

(run-tests proper-blue-eyed-ancestor-tests)
