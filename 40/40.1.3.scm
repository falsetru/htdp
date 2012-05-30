#lang racket

(define (make-movie title0 producer0)
  (local ((define title title0)
          (define producer producer0)
          (define (service-manager msg)
            (cond [(symbol=? msg 'title) title]
                  [(symbol=? msg 'producer) producer]
                  [else (error 'movie "Unknown message")]))
          )
         service-manager))
(define (movie-title x) (x 'title))
(define (movie-producer x) (x 'producer))

(define (make-boyfriend name0 hair0 eyes0 phone0)
  (local ((define name name0)
          (define hair hair0)
          (define eyes eyes0)
          (define phone phone0)
          (define (service-manager msg)
            (cond [(symbol=? msg 'name) name]
                  [(symbol=? msg 'hair) hair]
                  [(symbol=? msg 'eyes) eyes]
                  [(symbol=? msg 'phone) phone]
                  [else (error 'boyfriend "Unknown message")])))
         service-manager))
(define (boyfriend-name x) (x 'name))
(define (boyfriend-hair x) (x 'hair))
(define (boyfriend-eyes x) (x 'eyes))
(define (boyfriend-phone x) (x 'phone))

(define (make-cheerleader name0 number0)
  (local ((define name name0)
          (define number number0)
          (define (service-manager msg)
            (cond
                  [(symbol=? msg 'name) name]
                  [(symbol=? msg 'number) number]
                  [else (error 'cheerleader "Unknown message")])))
         service-manager))
(define (cheerleader-name x) (x 'name))
(define (cheerleader-number x) (x 'number))

(define (make-CD artist0 title0 price0)
  (local ((define artist artist0)
          (define title title0)
          (define price price0)
          (define (service-manager msg)
            (cond
                  [(symbol=? msg 'artist) artist]
                  [(symbol=? msg 'title) title]
                  [(symbol=? msg 'price) price]
                  [else (error 'CD "Unknown message")])))
         service-manager))
(define (CD-artist x) (x 'artist))
(define (CD-title x) (x 'title))
(define (CD-price x) (x 'price))

(define (make-sweater material0 size0 producer0)
  (local ((define material material0)
          (define size size0)
          (define producer producer0)
          (define (service-manager msg)
            (cond
                  [(symbol=? msg 'material) material]
                  [(symbol=? msg 'size) size]
                  [(symbol=? msg 'producer) producer]
                  [else (error 'sweater "Unknown message")])))
         service-manager))
(define (sweater-material x) (x 'material))
(define (sweater-size x) (x 'size))
(define (sweater-producer x) (x 'producer))

(require rackunit)
(require rackunit/text-ui)

(define make-movie-tests
  (test-suite
   "Test for make-movie"

   (test-case
    "movie"
    (define et (make-movie 'ET 'SS))
    (check-equal? (movie-title et) 'ET)
    (check-equal? (movie-producer et) 'SS)
    )
   ))

(exit (run-tests make-movie-tests))
