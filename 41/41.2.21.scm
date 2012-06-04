#lang racket


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


(define (v++ v i)
  (vector-set! v i (add1 (vector-ref v i))))


(define (count-ac ft result)
  (local ((define children (parent-children ft))
          (define nc
            (+ (length children)
               (foldr + 0 (map (lambda (p) (count-ac p result)) children)))))
         (begin
           (v++ result (min nc 5))
           nc)))

(define (count-children ft)
  (local ((define result (vector 0 0 0 0 0 0)))
         (begin
           (count-ac ft result)
           result)))

(require rackunit)
(require rackunit/text-ui)

(define count-children-tests
  (test-suite
   "Test for count-children"

   (check-equal? (count-children Carl) '#(3 1 0 0 1 0))
   ))

(exit (run-tests count-children-tests))
