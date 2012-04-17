(define (larger-items alon threshold) (filter (lambda (x) (> x threshold)) alon))
(define (smaller-items alon threshold) (filter (lambda (x) (< x threshold)) alon))

(require rackunit)
(require rackunit/text-ui)

(define larger-smaller-items-using-lambda-tests
  (test-suite
   "Test for larger-smaller-items-using-lambda"

   (check-equal? (larger-items '(2 5 1 6) 3) '(5 6))
   (check-equal? (smaller-items '(2 5 1 6) 3) '(2 1))
   ))

(exit (run-tests larger-smaller-items-using-lambda-tests))
