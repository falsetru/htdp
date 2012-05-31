#lang racket

(define-struct parent (children name date eyes no-descendants) #:mutable)

 ;; Youngest Generation:
(define Gustav (make-parent empty 'Gustav 1988 'brown 0))

(define Fred&Eva (list Gustav))

;; Middle Generation:
(define Adam (make-parent empty 'Adam 1950 'yellow 0))
(define Dave (make-parent empty 'Dave 1955 'black 0))
(define Eva (make-parent Fred&Eva 'Eva 1965 'blue 0))
(define Fred (make-parent Fred&Eva 'Fred 1966 'pink 0))

(define Carl&Bettina (list Adam Dave Eva))

;; Oldest Generation:
(define Carl (make-parent Carl&Bettina 'Carl 1926 'green 0))
(define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green 0))


(define (ft-descendants p)
  (begin
    (for-each (lambda (c) (ft-descendants c)) (parent-children p))
    (set-parent-no-descendants!
      p
      (+
        (length (parent-children p))
        (foldr + 0 (map parent-no-descendants (parent-children p))))
        )
    ))

(require rackunit)
(require rackunit/text-ui)

(define ft-descentdants-tests
  (test-suite
   "Test for ft-descentdants"

   (test-case ""
    (ft-descendants Carl)
    (check-equal? (parent-no-descendants Gustav) 0)
    (check-equal? (parent-no-descendants Eva) 1)
    (check-equal? (parent-no-descendants Dave) 0)
    (check-equal? (parent-no-descendants Adam) 0)
    (check-equal? (parent-no-descendants Carl) 4)
    (check-equal? (parent-no-descendants Bettina) 0)

    (ft-descendants Bettina)
    (check-equal? (parent-no-descendants Bettina) 4)
    )
   ))

(exit (run-tests ft-descentdants-tests))
