(define-struct parent (children name date eyes))

;; Youngest Generation:
(define Gustav (make-parent empty 'Gustav 1988 'brown))

(define Fred&Eva (list Gustav))

;; Middle Generation:
(define Adam (make-parent empty 'Adam 1950 'yellow))
(define Dave (make-parent empty 'Dave 1955 'black))
(define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
(define Fred (make-parent Fred&Eva 'Fred 1966 'pink))

(define Carl&Bettina (list Adam Dave Eva))

;; Oldest Generation:
(define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
(define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))

(define (blue-eyed-descendant? a-parent)
  (or (symbol=? (parent-eyes a-parent) 'blue)
      (local ((define children (parent-children a-parent))
              (define (blue-eyed-children? aloc)
                (cond
                  [(empty? aloc) false]
                  [else (or (blue-eyed-descendant? (first aloc))
                            (blue-eyed-children? (rest aloc)))])))
             (blue-eyed-children? children))))


(require rackunit)
(require rackunit/text-ui)

(define blue-eyed-descendant?-with-local-tests
  (test-suite
    "Test for blue-eyed-descendant?-with-local"

    (check-equal? (blue-eyed-descendant? Gustav) false)
    (check-equal? (blue-eyed-descendant? Eva) true)
    (check-equal? (blue-eyed-descendant? Bettina) true)
    ))

(run-tests blue-eyed-descendant?-with-local-tests)
