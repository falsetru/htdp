(require rackunit)
(require rackunit/text-ui)

(define filter-tests
  (test-suite "Test for filter"

   (test-case "1. eliminate-exp"
    (define-struct toy (name price))
    (define (eliminate-exp ua toys)
      (local ((define (cheap? toy) (< (toy-price toy) ua)))
             (filter cheap? toys)))
    (define got (eliminate-exp 15 (list (make-toy 'car 20)
                                        (make-toy 'doll 10))))
    (define want (list (make-toy 'doll 10)))
    (check-equal? (length got) (length want))
    (check-equal? (toy-name (first got)) (toy-name (first want))))

   (test-case "2. recall"
    (define (recall ty lon)
      (local ((define (good-enough x)
                (not (symbol=? x ty))))
             (filter good-enough lon)))
    (check-equal? (recall 'doll '(car bicycle doll robot))
                  '(car bicycle robot)))

   (test-case "3. selection"
    (define (selection xs ys)
      (local ((define (is-member? x xs)
                (and (cons? xs)
                     (or (equal? x (first xs))
                         (is-member? x (rest xs)))))
              (define (in-xs? y) (memq y xs)))
             (filter in-xs? ys)))
    (check-equal? (selection '(1 2 3 4) '(2 5 3)) '(2 3)))
   ))

(run-tests filter-tests)
