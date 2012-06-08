#lang racket

(require "43.2.1.scm")

(define (names-of-cousins person)
  (local ((define grand-father1 (person-father (person-father person)))
          (define grand-father2 (person-father (person-mother person)))
          (define father-sibling (person-children grand-father1))
          (define mother-sibling (person-children grand-father2))
          (define parent-sibling (append father-sibling mother-sibling)))
         (map person-name
           (filter (lambda (p) (not (eq? (person-father p) (person-father person))))
             (foldr append empty
               (map person-children parent-sibling))))))


(define 할아버지   (add-child! '할아버지    1 #f #f))
(define 할머니     (add-child! '할머니      2 #f #f))
(define 외할아버지 (add-child! '외할아버지  3 #f #f))
(define 외할머니   (add-child! '외할머니    4 #f #f))
(define 고모부     (add-child! '고모부      5 #f #f))
(define 고모       (add-child! '고모        6 할아버지 할머니))
(define 큰아버지   (add-child! '큰아버지    7 할아버지 할머니))
(define 큰어머니   (add-child! '큰어머니    8 #f #f))
(define 외숙       (add-child! '외숙        9 외할아버지 외할머니))
(define 외숙모     (add-child! '외숙모     10 #f #f))
(define 어머니     (add-child! '어머니     11 외할아버지 외할머니))
(define 이모       (add-child! '이모       12 외할아버지 외할머니))
(define 이모부     (add-child! '이모부     13 #f #f))
(define 아버지     (add-child! '아버지     14 할아버지   할머니))
(define 나         (add-child! '나         15 아버지     어머니))
(define 동생       (add-child! '동생       16 아버지     어머니))
(define 사촌1      (add-child! '사촌1      17 고모부     고모))
(define 사촌2      (add-child! '사촌2      18 큰아버지   큰어머니))
(define 외사촌1    (add-child! '외사촌1    19 외숙       외숙모))
(define 외사촌2    (add-child! '외사촌2    20 외숙       외숙모))
(define 외사촌3    (add-child! '외사촌3    21 이모부     이모  ))
(define 외사촌4    (add-child! '외사촌4    22 이모부     이모  ))

(require rackunit)
(require rackunit/text-ui)

(define names-of-cousins-tests
  (test-suite
   "Test for names-of-cousins"

   (check-equal? (names-of-cousins 나) '(사촌2 사촌1 외사촌4 외사촌3 외사촌2 외사촌1))
   ))

(exit (run-tests names-of-cousins-tests))
