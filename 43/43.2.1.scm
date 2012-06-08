#lang racket

(define-struct person (name social father mother children) #:mutable)

(define (add-child! name soc-sec father mother)
  (local ((define the-child (make-person name soc-sec father mother empty)))
         (begin
           (if (person? father) (set-person-children! father (cons the-child (person-children father))) (void))
           (if (person? mother) (set-person-children! mother (cons the-child (person-children mother))) (void))
           the-child)))

(define Carl    (add-child! 'Carl    1926 #f #f))
(define Bettina (add-child! 'Bettina 1926 #f #f))
(define Adam    (add-child! 'Adam    1950 Carl Bettina))
(define Dave    (add-child! 'Dave    1955 Carl Bettina))
(define Eva     (add-child! 'Eva     1965 Carl Bettina))
(define Fred    (add-child! 'Fred    1966 #f #f))
(define Gustav  (add-child! 'Gustav  1988 Fred Eva))

(require rackunit)
(require rackunit/text-ui)

(define add-child!-tests
  (test-suite
   "Test for add-child!"

   (check-equal? (person-children Eva) (list Gustav))
   (check-equal? (person-father Gustav) Fred)
   (check-equal? (person-mother Gustav) Eva)
   ))

(exit (run-tests add-child!-tests))
