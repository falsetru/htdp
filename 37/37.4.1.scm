;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.4.1) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))

(define (convert a-list-of-nums)
  (cond
    [(empty? a-list-of-nums) 0]
    [else (+ (first a-list-of-nums)
             (* (convert (rest a-list-of-nums)) 10))]))

(define how-many-clicks 0)
(define (check-guess-for-list a-list-of-nums number)
  (begin
    (set! how-many-clicks (add1 how-many-clicks))
    ;(display how-many-clicks) (newline)
    (cond
      [(< (convert a-list-of-nums) number) 'TooSmall]
      [(> (convert a-list-of-nums) number) 'TooLarge]
      [else 'Perfect])))

(guess-with-gui-list 5 check-guess-for-list)