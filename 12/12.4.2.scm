(require rackunit)
(require rackunit/text-ui)

(define (insert-everywhere prefix c suffix)
  (cond [(empty? suffix) (list (append prefix (list c)))]
        [else
          (cons
            (append prefix (list c) suffix)
            (insert-everywhere (append prefix (take suffix 1)) c (rest suffix)))]))

(define (insert-everywhere/in-all-words c words)
  (cond [(empty? words) empty]
        [else (append (insert-everywhere empty c (first words))
                      (insert-everywhere/in-all-words c (rest words)))]))

(define (arrangements a-word)
  (cond
    [(empty? a-word) (cons empty empty)]
    [else (insert-everywhere/in-all-words (first a-word) 
            (arrangements (rest a-word)))]))

(define 12.4.2-tests
  (test-suite
   "Test for 12.4.2"

   (check-equal? (insert-everywhere empty 'a empty)
                 '((a)))

   (check-equal? (insert-everywhere '(x y) 'a empty)
                 '((x y a)))

   (check-equal? (insert-everywhere empty 'a '(b))
                 '((a b) (b a)))

   (check-equal? (insert-everywhere '(x) 'a '(b))
                 '((x a b) (x b a)))

   (check-equal? (insert-everywhere empty 'a '(b c))
                 '((a b c) (b a c) (b c a)))

   (check-equal? (arrangements empty)
                 '(()))

   (check-equal? (arrangements '(a))
                 '((a)))

   (check-equal? (arrangements '(a b))
                 '((a b) (b a)))

   (check-equal? (arrangements '(a b c))
                 '((a b c) (b a c) (b c a) (a c b) (c a b) (c b a)))

   (check-equal? (arrangements '(a b c d))
                 '((a b c d) (b a c d) (b c a d) (b c d a) (a c b d) (c a b d)
                   (c b a d) (c b d a) (a c d b) (c a d b) (c d a b) (c d b a)
                   (a b d c) (b a d c) (b d a c) (b d c a) (a d b c) (d a b c)
                   (d b a c) (d b c a) (a d c b) (d a c b) (d c a b) (d c b a)))
   ))

(exit (run-tests 12.4.2-tests))
