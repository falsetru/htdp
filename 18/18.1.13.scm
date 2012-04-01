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

(define (to-blue-eyed-ancestor ftn)
  (cond [(empty? ftn) false]
        [(symbol=? (child-eyes ftn) 'blue) empty]
        [else
          (local ((define f (to-blue-eyed-ancestor (child-father ftn)))
                  (define m (to-blue-eyed-ancestor (child-mother ftn))))
                 (cond [(list? f) (cons 'father f)]
                       [(list? m) (cons 'mother m)]
                       [else false]))]))

(require rackunit)
(require rackunit/text-ui)

(define to-blue-eyed-ancestor-tests
  (test-suite "Test for to-blue-eyed-ancestor"

   (test-case ""
    (check-equal? (to-blue-eyed-ancestor Gustav) '(mother))
    (check-equal? (to-blue-eyed-ancestor Adam) false)
    (define Hal (make-child Gustav Eva 'Hal 1988 'hazel))
    (check-equal? (to-blue-eyed-ancestor Hal) '(father mother))
    )
   ))

(run-tests to-blue-eyed-ancestor-tests)
