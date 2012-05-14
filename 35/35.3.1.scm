#lang racket

(define (f x y)
  (begin 
    (set! x y)
    y))

; syntactically legal
