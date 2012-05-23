#lang racket

(provide
  (struct-out building)
  )

(define-struct building (name pic near-buildings))
; name: symbol
; pic: picture
; near-buildings: (listof symbol)

; campus: (listof building)
