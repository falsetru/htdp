(require rackunit)
(require rackunit/text-ui)

(define (abs-fun f)
  (local ((define (concrete-fun xs)
          (cond [(empty? xs) empty]
                [else (cons (f (first xs)) (concrete-fun (rest xs)))])))
         concrete-fun))

(define abstraction-tests
  (test-suite "Test for abstraction"

   (test-case "convertCF"
    (define (C->F x) (add1 x))
    (define convertCF (abs-fun C->F))
    (check-equal? (convertCF '(1 2 3)) '(2 3 4)))

   (test-case "IR-name"
    (define-struct IR (name price))
    (define names (abs-fun IR-name))
    (check-equal? (names (list (make-IR 'doll 1)
                               (make-IR 'car 2)
                               (make-IR 'mouse 1)))
                  '(doll car mouse)))

   ))

(run-tests abstraction-tests)
