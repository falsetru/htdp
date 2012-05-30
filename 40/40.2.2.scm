(define (ffm-make-posn x0 y0)
  (local ((define x x0)
	  (define (set-x new-x) (set! x new-x))
	  (define y y0)
	  (define (set-y new-y) (set! y new-y)))
  (lambda (select)
    (select x y set-x set-y))))

(define (ffm-posn-x a-ffm-posn)
  (a-ffm-posn (lambda (x y sx sy) x)))

(define (ffm-posn-y a-ffm-posn)
  (a-ffm-posn (lambda (x y sx sy) y)))

(define (ffm-set-posn-x! a-ffm-posn new-value)
  (a-ffm-posn (lambda (x y sx sy) (sx new-value))))

(define (ffm-set-posn-y! a-ffm-posn new-value)
  (a-ffm-posn (lambda (x y sx sy) (sy new-value))))


;;;;
(define p (ffm-make-posn 3 4))
(ffm-set-posn-y! p 5)

=
(define x 3)
(define y 4)
(define (set-x new-x) (set! x new-x))
(define (set-y new-y) (set! y new-y))
(define p (lambda (select) (select x y set-x set-y)))
(ffm-set-posn-y! p 5)

=
(define x 3)
(define y 4)
(define (set-x new-x) (set! x new-x))
(define (set-y new-y) (set! y new-y))
(define (ffm-set-posn-y! (lambda (select) (select x y set-x set-y)) 5)
  (a-ffm-posn (lambda (x y sx sy) (sy 5))))

=
(define x 3)
(define y 4)
(define (set-x new-x) (set! x new-x))
(define (set-y new-y) (set! y new-y))
((lambda (select) (select x y set-x set-y))
 (lambda (x y sx sy) (sy 5)))

=
((lambda (x y sx sy) (sy 5)) x y set-x set-y)

=
(define x 3)
(define y 4)
(define (set-x new-x) (set! x new-x))
(define (set-y new-y) (set! y new-y))
(set-y 5)

=
(define x 3)
(define y 4)
(set! y 5)

=
(define x 3)
(define y 5)
