(define var? symbol?)
(define-struct Lam (var expr) #:transparent)
(define-struct LamApply (lam arg) #:transparent) ; lam is Lam, arg is <exp>


(define (tbl-lookup tbl key)
  (local ((define x (assoc key tbl)))
         (cond [(cons? x) (second x)]
               [else key])))

(define (unique-binding lam)
  (uniq-Lam lam '()))

(define (uniq expr tbl)
  (cond [(var? expr)      (uniq-Var expr tbl)]
        [(Lam? expr)      (uniq-Lam expr tbl)]
        [(LamApply? expr) (uniq-LamApply expr tbl)]))

(define (uniq-Var expr tbl)
  (tbl-lookup tbl expr))

(define (uniq-Lam expr tbl)
  (local ((define v (Lam-var expr))
          (define e (Lam-expr expr))
          (define v2 (gensym v))
          (define t (cons (list v v2) tbl)))
         (make-Lam v2 (uniq e t))))

(define (uniq-LamApply expr tbl)
  (make-LamApply
    (uniq-Lam (LamApply-lam expr) tbl)
    (uniq (LamApply-arg expr) tbl)))


(require rackunit)
(require rackunit/text-ui)

(define unique-binding-tests
  (test-suite
   "Test for unique-binding"

   (test-case "gensym"
    (check-not-equal? (gensym) (gensym))
    (check-not-equal? (gensym 'a) (gensym 'a)))

   (test-case "tbl-lookup"
    (check-equal? (tbl-lookup '((a b) (b c)) 'a) 'b)
    (check-equal? (tbl-lookup '((a b) (b c)) 'c) 'c)
    (check-equal? (tbl-lookup '((a b) (b c) (a y)) 'a) 'b))

   (test-case
    "unique-binding: Can't test.
     1. gensym generate random symbol.
     2. gensym-generated symbol is uninterned / literal is intered. not-'equal?'''"
;    (check-equal? (unique-binding (make-Lam 'x 'x))
;                  (make-Lam 'x221 'x221))
     (printf "~a\n" (unique-binding (make-Lam 'x 'x)))
     (printf "~a\n" (unique-binding (make-Lam 'x 'y)))
     (printf "~a\n" (unique-binding (make-Lam 'x (make-Lam 'x 'x))))
     (printf "~a\n" (unique-binding (make-Lam 'x (make-LamApply (make-Lam 'x 'x) 'x))))
    )
   ))

(exit (run-tests unique-binding-tests))
