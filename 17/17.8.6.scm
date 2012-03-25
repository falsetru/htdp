(define wp? cons?)

(define (web=? a-wp another-wp)
  (cond
    [(empty? a-wp) (empty? another-wp)]
    [(symbol? (first a-wp))
     (and (and (cons? another-wp) (symbol? (first another-wp)))
          (and (symbol=? (first a-wp) (first another-wp))
               (web=? (rest a-wp) (rest another-wp))))]
    [else
      (and (and (cons? another-wp) (wp? (first another-wp)))
           (and (web=? (first a-wp) (first another-wp))
                (web=? (rest a-wp) (rest another-wp))))]))


; +----------------+--------+---------------+-------------------+
; |                | empty? | (cons s wp)   | (cons ewp wp)     |
; +----------------+--------+---------------+-------------------+
; | empty?         |   O    |      X        |       X           |
; +----------------+--------+---------------+-------------------+
; | (cons s' wp)   |   X    | s=s' & wp=wp' |       X           |
; +----------------+--------+---------------+-------------------+
; | (cons ewp' wp) |   X    |      X        | ewp=ewp' & wp=wp' |
; +----------------+--------+---------------+-------------------+

(require rackunit)
(require rackunit/text-ui)

(define web-page-equals-tests
  (test-suite
   "Test for web-page-equals"

   (test-case "web=?"
    (check-equal? 1 1)
    (define a '(a a b))
    (define b '(a b c))
    (define c '((a b) x y z))
    (define d '(a b (x y)))
    (define e '(a (x y) z))

    (check-equal? (web=? a a) true)
    (check-equal? (web=? b b) true)
    (check-equal? (web=? c c) true)
    (check-equal? (web=? d d) true)
    (check-equal? (web=? e e) true)
    (check-equal? (web=? a b) false)
    (check-equal? (web=? a c) false)
    (check-equal? (web=? a d) false)
    (check-equal? (web=? a e) false)
    (check-equal? (web=? c d) false)
    (check-equal? (web=? c e) false)
    (check-equal? (web=? e d) false)
    )

   ))

(run-tests web-page-equals-tests)
