#lang racket

(define-struct child (name social father mother) #:mutable)

;; Oldest Generation:
(define Carl (make-child 'Carl 1926 false false))
(define Bettina (make-child 'Bettina 1926 false false))

;; Middle Generation:
(define Adam (make-child 'Adam 1950 Carl Bettina))
(define Dave (make-child 'Dave 1955 Carl Bettina))
(define Eva (make-child 'Eva 1965 Carl Bettina))
(define Fred (make-child 'Fred 1966 false false))

;; Youngest Generation: 
(define Gustav (make-child 'Gustav 1988 Fred Eva))

(define (add-ftn! a-ft ssc anc a-ftn)
  (local ((define set-parent! (if (symbol=? anc 'father) set-child-father! set-child-mother!))
          (define get-parent (if (symbol=? anc 'father) child-father child-mother))
          (define (add-ftn-real! a-ft)
            (cond [(false? a-ft) false]
                  [(= (child-social a-ft) ssc)
                   (cond [(false? (get-parent a-ft))
                          (begin
                            (set-parent! a-ft a-ftn)
                            true)]
                         [else
                           (error 'add-ftn! "already set")])]
                  [else
                    (or
                      (add-ftn-real! (child-father a-ft))
                      (add-ftn-real! (child-mother a-ft))
                      )]))
          )
         (add-ftn-real! a-ft)))


(require rackunit)
(require rackunit/text-ui)

(define add-ftn!-tests
  (test-suite
   "Test for add-ftn!"

   (test-case
    ""
    (define Peter (make-child 'Peter 1890 false false))
    (define Jane (make-child 'Jane 1892 false false))
    (add-ftn! Gustav (child-social Carl) 'father Peter)
    (check-equal? (child-father Carl) Peter)
    (check-equal? (child-mother Carl) false)
    (check-exn
      exn?
      (lambda ()
        (add-ftn! Gustav (child-social Carl) 'father Peter)))
    (add-ftn! Gustav (child-social Carl) 'mother Jane)
    (check-equal? (child-mother Carl) Jane)
    )
   ))

(exit (run-tests add-ftn!-tests))
