#lang racket

; http://club.filltong.net/codingdojo/29963

(require racket/runtime-path)

(define-runtime-path guess-zip-path "guess.zip")

(define (make-real-interact)
  (local ((define-values
            (s stdout stdin stderr)
            (subprocess #f #f #f "/usr/bin/python" "-u" guess-zip-path))
          (define (interact guess)
            (write-bytes guess stdin)
            (write-bytes #"\n" stdin)
            (flush-output stdin)
            (read-bytes-line stdout 'any)
            ))
         interact))

(define (make-fake-interact word)
  (local ((define (interact guess)
            (cond [(bytes<? word guess) #"<"]
                  [(bytes>? word guess) #">"]
                  [else #"="])))
         interact))

(define (solve interact)
  (local ((define (solve-aux word low high)
            (local ((define cmp (interact word)))
                   (cond [(bytes=? cmp #"=") word]
                         [(bytes=? cmp #"<") (solve-aux (next-word low word) low word)]
                         [(bytes=? cmp #">") (solve-aux (next-word word high) word high)]
                         [else (error 'solve "Unexpected output from interact")]))
            ))
         (solve-aux #"a" #"a" #"{")))

(define (next-word low high)
  (local ((define last-char (bytes-ref low (sub1 (bytes-length low))))
          (define next-char (add1 last-char))
          (define next-bytes (bytes next-char))
          (define word (bytes-append (subbytes low 0 (sub1 (bytes-length low))) next-bytes)))
         (if (bytes<? word high)
           word
           (bytes-append low #"a"))))

(require rackunit)
(require rackunit/text-ui)

(define guess-tests
  (test-suite
   "Test for guess"

   (test-case
    "next-word"
    (check-equal? (next-word #"a" #"z") #"b")
    (check-equal? (next-word #"aa" #"a{") #"ab")
    (check-equal? (next-word #"a" #"b") #"aa")
    )

   (test-case
    "solve"
    (check-equal? (solve (make-fake-interact #"word")) #"word")
    (check-equal? (solve (make-fake-interact #"a")) #"a")
    (check-equal? (solve (make-fake-interact #"zz")) #"zz")
    )
   ))

(run-tests guess-tests)
(solve (make-real-interact))
