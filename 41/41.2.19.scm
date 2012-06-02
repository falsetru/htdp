#lang racket

(require "41.2.18.scm")

(define alphabets '#(a b c d e f g h i j k l m n o p q r s t u v w x y z))
(define alphabets# (vector-length alphabets))
(define (build-alpha-list n)
  (build-list
    n
    (lambda (i) (vector-ref alphabets (random alphabets#)))))

(define (count-vowels-bv chars)
  (local ((define (count-vowel x chars)
            (cond
              [(empty? chars) 0]
              [else (cond
                      [(symbol=? x (first chars))
                       (+ (count-vowel x (rest chars)) 1)]
                      [else (count-vowel x (rest chars))])])))
    (build-vector 5 (lambda (i) 
                      (cond
                        [(= i 0) (count-vowel 'a chars)]
                        [(= i 1) (count-vowel 'e chars)]
                        [(= i 2) (count-vowel 'i chars)]
                        [(= i 3) (count-vowel 'o chars)]
                        [(= i 4) (count-vowel 'u chars)])))))

(define (count-vowels-ac chars)
  (local ((define (count chars v)
            (cond [(empty? chars) (void)]
                  [else
                    (begin
                      (count-a-vowel (first chars) v)
                      (count (rest chars) v))]))
          (define c (vector 0 0 0 0 0)))
         (begin
           (count chars c)
           c
           )))


(define (bm n)
  (local ((define sample (build-alpha-list n)))
         (printf "count-vowels    (~a) : " (length sample))
         (time (count-vowels    sample))
         (collect-garbage)
         (printf "count-vowels-bv (~a) : " (length sample))
         (time (count-vowels-bv sample))
         (collect-garbage)
         (printf "count-vowels-ac (~a) : " (length sample))
         (time (count-vowels-ac sample))
         (collect-garbage)
         ))

(for-each
  bm
  (build-list 8 (lambda (i) (expt 10 i)))
  )
