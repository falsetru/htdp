#lang racket

(define (sum xs) (foldr + 0 xs))

(define JANUS
  (list #i31
        #i2e+34
        #i-1.2345678901235e+80
        #i2749
        #i-2939234
        #i-2e+33
        #i3.2e+270
        #i17
        #i-2.4e+270
        #i4.2344294738446e+170
        #i1
        #i-8e+269
        #i0
        #i99))

(display (sum JANUS)) (newline)
(display (sum (reverse JANUS))) (newline)

(display (- (sum JANUS) (sum (reverse JANUS)))) (newline)
