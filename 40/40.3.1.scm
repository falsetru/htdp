#lang racket

;(require (lib "htdp-advanced-reader.ss" "lang"))

(require rackunit)
(require rackunit/text-ui)

(define struct-mutators-tests
  (test-suite
   "Test for struct-mutators"

   (test-case "1."
    (define-struct movie (title producer) #:mutable)
    (check-true (procedure? set-movie-title!))
    (check-true (procedure? set-movie-producer!)))

   (test-case "2."
    (define-struct boyfriend (name hair eyes phone) #:mutable)
    (check-true (procedure? set-boyfriend-name!))
    (check-true (procedure? set-boyfriend-hair!))
    (check-true (procedure? set-boyfriend-eyes!))
    (check-true (procedure? set-boyfriend-phone!)))

   (test-case "3."
    (define-struct cheerleader (name number) #:mutable)
    (check-true (procedure? set-cheerleader-name!))
    (check-true (procedure? set-cheerleader-number!)))

   (test-case "4."
    (define-struct CD (artist title price) #:mutable)
    (check-true (procedure? set-CD-artist!))
    (check-true (procedure? set-CD-title!))
    (check-true (procedure? set-CD-price!)))

   (test-case "5."
    (define-struct sweater (material size producer) #:mutable)
    (check-true (procedure? set-sweater-material!))
    (check-true (procedure? set-sweater-size!))
    (check-true (procedure? set-sweater-producer!)))
   ))



(exit (run-tests struct-mutators-tests))
