#lang racket

(define COLORS
  '(black white red blue green gold pink orange purple navy))


(define (make-master)
  (local ((define target1 (first COLORS))
          (define target2 (first COLORS))

          (define (random-pick xs)
            (list-ref xs (random (length xs))))

          (define (master)
            (begin (set! target1 (random-pick COLORS))
                   (set! target2 (random-pick COLORS))
                   ))

          (define (check-color guess1 guess2 target1 target2)
            (cond [(and (symbol=? guess1 target1) (symbol=? guess2 target2)) 'Perfect!]
                  [(or (symbol=? guess1 target1) (symbol=? guess2 target2)) 'OneColorAtCorrectPosition]
                  [(or (symbol=? guess1 target2) (symbol=? guess2 target1)) 'OneColorOccurs]
                  [else 'NothingCorrect]))

          (define (master-check guess1 guess2)
            (check-color guess1 guess2 target1 target2))

          (define (setup-targets t1 t2)
            (begin
              (set! target1 t1)
              (set! target2 t2)))

          (define (service-manager msg)
            (cond [(symbol=? msg 'master-check) master-check]
                  [(symbol=? msg 'cheat) (list target1 target2)]
                  [(symbol=? msg 'cheat2) setup-targets]
                  [else (error 'make-master "message not understood")]))
          )

         service-manager
         ))

(require rackunit)
(require rackunit/text-ui)

(define make-master-tests
  (test-suite
   "Test for make-master"

   (test-case
    ""
    (define master1 (make-master))
    (define master-check (master1 'master-check))
    ((master1 'cheat2) 'pink 'navy)

    (check-equal? (master1 'cheat) '(pink navy))
    (check-equal? (master-check 'red 'red) 'NothingCorrect)
    (check-equal? (master-check 'black 'pink) 'OneColorOccurs)
    )
   ))

(exit (run-tests make-master-tests))
