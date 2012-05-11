#lang racket
(provide
  (struct-out inex)
  create-inex
  inex-adjust
  )


(define-struct inex (mantissa sign exponent) #:transparent)

(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s +1) (= s -1)))
     (make-inex m s e)]
    [else
     (error 'make-inex "(<= 0 m 99), +1 or -1, (<= 0 e 99) expected")]))

(define (inex-adjust i e-delta)
  (local ((define e (* (inex-sign i) (inex-exponent i)))
          (define e-new (+ e e-delta)))
         (create-inex
           (round (/ (inex-mantissa i) (expt 10 e-delta)))
           (if (< e-new 0) -1 +1)
           (abs e-new))))


(define (naive-inex+ a b)
  (local ((define i  
            (make-inex
              (+ (inex-mantissa a) (inex-mantissa b))
              (inex-sign a)
              (inex-exponent a))))
         (cond [(> (inex-mantissa i) 99) (inex-adjust i 1)]
               [else i]
           )))

(define (inex+ a b)
  (local ((define e-a (* (inex-sign a) (inex-exponent a)))
          (define e-b (* (inex-sign b) (inex-exponent b))))
         (cond [(= e-a e-b) (naive-inex+ a b)]
               [(< e-a e-b) (inex+ b a)]
               [(< (inex-mantissa a) 10) (naive-inex+ (inex-adjust a -1) b)]
               [else                     (naive-inex+ a (inex-adjust b +1))])))

(require rackunit)
(require rackunit/text-ui)

(define inex+-tests
  (test-suite
   "Test for inex+"

   (check-equal? (inex-adjust (make-inex 100 1 0) 1)
                 (create-inex 10 1 1))
   (check-equal? (inex-adjust (make-inex 1 1 0) -1)
                 (create-inex 10 -1 1))
   (check-equal? (inex-adjust (make-inex 10001 1 0) 3)
                 (create-inex 10 1 3))

   (check-equal? (naive-inex+ (create-inex 1 1 0) (create-inex 2 1 0))
                 (create-inex 3 1 0))
   (check-equal? (naive-inex+ (create-inex 56 1 0) (create-inex 56 1 0))
                 (create-inex 11 1 1))
   (check-equal? (naive-inex+ (create-inex 56 -1 3) (create-inex 56 -1 3))
                 (create-inex 11 -1 2))
   (check-exn exn? (lambda ()
                     (naive-inex+ (create-inex 99 1 99) (create-inex 99 1 99))))

   (check-equal? (inex+ (create-inex 1 +1 0) (create-inex 1 -1 1))
                 (create-inex 11 -1 1))
   (check-equal? (inex+ (create-inex 1 -1 1) (create-inex 1 +1 0))
                 (create-inex 11 -1 1))
   (check-equal? (inex+ (create-inex 99 +1 98) (create-inex 9 +1 97))
                 (create-inex 10 +1 99))
   ))

(run-tests inex+-tests)
