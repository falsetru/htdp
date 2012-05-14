#lang racket

; 1.
; (set! x 5)
;
; set!: unbound identifier in module in: x


; 2.
; (define x 3)
; (set! (+ x 1) 5)
;
; set!: not an identifier at: (+ x 1) in: (set! (+ x 1) 5)

; 3.
; (define x 3)
; (define y 7)
; (define z false)
; (set! (z x y) 5)
;
; set!: not an identifier at: (z x y) in: (set! (z x y) 5)
