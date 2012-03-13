(define (whose-number phonebook number)
  (cond [(empty? phonebook) false]
        [(symbol=? (second (first phonebook)) number) (first (first phonebook))]
        [else (whose-number (rest phonebook) number)]))

(define (phone-number phonebook name)
  (cond [(empty? phonebook) false]
        [(symbol=? (first (first phonebook)) name) (second (first phonebook))]
        [else (phone-number (rest phonebook) name)]))

(require rackunit)
(require rackunit/text-ui)

(define phonebook
  (list
    (list 'Matthias '123-4567)
    (list 'Robert '234-5678)
    (list 'Matthew '345-6789)
    (list 'Shriram '456-7890)))

(define 10.2.4-tests
  (test-suite
   "Test for 10.2.4"

   (check-equal? (whose-number phonebook '234-5678) 'Robert)
   (check-equal? (whose-number phonebook '345-6789) 'Matthew)
   (check-equal? (whose-number phonebook '999-9999) false)
   (check-equal? (phone-number phonebook 'Matthias) '123-4567)
   (check-equal? (phone-number phonebook 'Shriram) '456-7890)
   (check-equal? (phone-number phonebook 'no-such-person) false)
   ))

(run-tests 10.2.4-tests)
