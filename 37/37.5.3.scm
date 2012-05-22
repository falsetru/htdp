#lang racket

(define-struct building (name pic near-buildings item))
; name: symbol
; pic: picture
; near-buildings: (listof symbol)
; item: symbol or false

; campus: (listof building)
(define RICE-University
  (list (make-building 'MuddBuilding  'MuddBuilding-pic '(EngineeringQ Bio-Engineers) 'mud)
        (make-building 'Bio-Engineers 'Bio-Engineers-pic '(MuddBuilding) 'frog)
        (make-building 'EngineeringQ  'EngineeringQ-pic '(MuddBuilding) 'machine)))


(define pos (first RICE-University))
(define (show-me) (building-pic pos))
(define (where-to-go)
  (building-near-buildings pos))
(define (go s)
  (local ((define (try-go s buildings)
            (cond [(empty? buildings) (error 'go "No such near building.")]
                  [(symbol=? s (building-name (first buildings)))
                   (set! pos (first buildings))]
                  [else (try-go s (rest buildings))])))
         (try-go s RICE-University)))

(define INVENTORY-CAPACITY 2)
(define inventory empty)
(define (can-replace?)
  (and
    (symbol? (building-item pos))
    (cons? inventory)))
(define (can-add?)
  (and
    (symbol? (building-item pos))
    (< (length inventory) INVENTORY-CAPACITY)))
(define (inv+)
  (begin
    (set! inventory (cons (building-item pos) inventory))
    (set! pos (make-building (building-name pos)
                             (building-pic pos)
                             (building-near-buildings pos)
                             false))
    ;;;; XXX replace RICE-University
    ))
(define (inv-replace idx)
  (local ((define bld-itm (building-item pos))
          (define inv-itm (list-ref inventory idx)))
         (begin
           (set! pos (make-building (building-name pos)
                                    (building-pic pos)
                                    (building-near-buildings pos)
                                    inv-itm))
           (set! inventory
             (append (take inventory idx) (list bld-itm) (drop inventory (add1 idx))))
           )))
(define (take!)
  (cond [(can-add?) (inv+)]
        [(can-replace?) (inv-replace 0)]
        [else (void)]))

(require rackunit)
(require rackunit/text-ui)

(define greey-explorer-tests
  (test-suite
   "Test for greey-explorer"

   (test-case
    "take all!"
    (set! pos (first RICE-University))
    (check-equal? inventory empty)
    (check-equal? (can-add?) true)
    (check-equal? (can-replace?) false)
    (take!)
    (check-equal? inventory '(mud))
    (check-equal? (building-item pos) false)
    (check-equal? (can-add?) false)
    (check-equal? (can-replace?) false)

    (go 'EngineeringQ)
    (check-equal? (can-add?) true)
    (check-equal? (can-replace?) true)
    (take!)
    (check-equal? inventory '(machine mud))
    (check-equal? (building-item pos) false)
    (check-equal? (can-add?) false)
    (check-equal? (can-replace?) false)

    (go 'MuddBuilding)
    (go 'Bio-Engineers)
    (check-equal? (can-add?) false)
    (check-equal? (can-replace?) true)
    (take!)
    (check-equal? inventory '(frog mud))
    (check-equal? (building-item pos) 'machine)
    (check-equal? (can-add?) false)
    (check-equal? (can-replace?) true)
    )
   ))

(exit (run-tests greey-explorer-tests))
