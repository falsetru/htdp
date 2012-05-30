#lang racket

(define (make-boyfriend name0 hair0 eyes0 phone0)
  (local ((define name name0)
          (define hair hair0)
          (define eyes eyes0)
          (define phone phone0)
          (define (service-manager msg)
            (cond [(symbol=? msg 'name) name]
                  [(symbol=? msg 'hair) hair]
                  [(symbol=? msg 'eyes) eyes]
                  [(symbol=? msg 'phone) phone]
                  [(symbol=? msg 'set-name) (lambda (value) (set! name value))]
                  [(symbol=? msg 'set-hair) (lambda (value) (set! hair value))]
                  [(symbol=? msg 'set-eyes) (lambda (value) (set! eyes value))]
                  [(symbol=? msg 'set-phone) (lambda (value) (set! phone value))]
                  [else (error 'boyfriend "Unknown message")])))
         service-manager))
(define (boyfriend-name x) (x 'name))
(define (boyfriend-hair x) (x 'hair))
(define (boyfriend-eyes x) (x 'eyes))
(define (boyfriend-phone x) (x 'phone))
(define (boyfriend-set-name!  x value) ((x 'set-name) value))
(define (boyfriend-set-hair!  x value) ((x 'set-hair) value))
(define (boyfriend-set-eyes!  x value) ((x 'set-eyes) value))
(define (boyfriend-set-phone! x value) ((x 'set-phone) value))

(require rackunit)
(require rackunit/text-ui)

(define make-boyfriend-tests
  (test-suite
   "Test for make-boyfriend"

   (test-case
    "boyfriend"
    (define a-boy (make-boyfriend 'John 'black 'brown '1234))
    (boyfriend-set-name! a-boy 'Jack)
    (boyfriend-set-eyes! a-boy 'blue)
    (check-equal? (boyfriend-name a-boy) 'Jack)
    (check-equal? (boyfriend-hair a-boy) 'black)
    (check-equal? (boyfriend-eyes a-boy) 'blue)
    (check-equal? (boyfriend-phone a-boy) '1234)
    )
   ))

(exit (run-tests make-boyfriend-tests))
