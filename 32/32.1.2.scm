(define var? symbol?)
(define-struct Lam (var expr) #:transparent)
(define-struct LamApply (lam arg) #:transparent) ; lam is Lam, arg is <exp>

;(define (free-or-bound lam)
;  (local ((define v (Lam-var lam))
;          (define e (Lam-expr lam)))
;         (cond [(var? e) (make-Lam v (if (symbol=? e v) 'bound 'free))]
;               [(Lam? e) (make-Lam v (free-or-bound e))])))

(define (free-or-bound-expr e seen-vars)
  (cond [(var? e) (if (memq e seen-vars) 'bound 'free)]
        [(Lam? e) (free-or-bound-acc e seen-vars)]
        [(LamApply? e)
           (make-LamApply
             (free-or-bound-acc (LamApply-lam e) seen-vars)
             (free-or-bound-expr (LamApply-arg e) seen-vars))])
  )
(define (free-or-bound-acc lam seen-vars)
  (local ((define v (Lam-var lam))
          (define e (Lam-expr lam)))
         (make-Lam
           v
           (free-or-bound-expr e (cons v seen-vars)))))

(define (free-or-bound lam)
  (free-or-bound-acc lam empty))


(require rackunit)
(require rackunit/text-ui)

(define free-or-bound-tests
  (test-suite
   "Test for free-or-bound"

   (check-equal? (free-or-bound (make-Lam 'x 'x)) (make-Lam 'x 'bound))
   (check-equal? (free-or-bound (make-Lam 'x 'y)) (make-Lam 'x 'free))
   (check-equal? (free-or-bound (make-Lam 'x (make-Lam 'y 'x)))
                 (make-Lam 'x (make-Lam 'y 'bound)))
   (check-equal? (free-or-bound (make-Lam 'x (make-LamApply (make-Lam 'y 'x) 'x)))
                 (make-Lam 'x (make-LamApply (make-Lam 'y 'bound) 'bound)))
   (check-equal? (free-or-bound (make-Lam 'x (make-LamApply (make-Lam 'y 'x) 'z)))
                 (make-Lam 'x (make-LamApply (make-Lam 'y 'bound) 'free)))
   ))

(exit (run-tests free-or-bound-tests))
