#lang racket

(define (count-vowels chars)
  (cond
    [(empty? chars) (vector 0 0 0 0 0)]
    [else
     (local ((define count-rest (count-vowels (rest chars))))
       (begin
         (count-a-vowel (first chars) count-rest)
         count-rest))]))

(define (count-a-vowel letter counts)
  (cond [(symbol=? letter 'a) (v++ counts 0)]
        [(symbol=? letter 'e) (v++ counts 1)]
        [(symbol=? letter 'i) (v++ counts 2)]
        [(symbol=? letter 'o) (v++ counts 3)]
        [(symbol=? letter 'u) (v++ counts 4)]
        [else (void)]))

(define (v++ v i) (vector-set! v i (add1 (vector-ref v i))))

(require rackunit)
(require rackunit/text-ui)

(define count-vowels-tests
  (test-suite
   "Test for count-vowels"

   (check-equal? (count-vowels '(a b c d e f g h i)) '#(1 1 1 0 0))
   (check-equal? (count-vowels '(a a i u u)) '#(2 0 1 0 2))
   ))

(exit (run-tests count-vowels-tests))
