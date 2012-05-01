(define (vector+ a b)
  (build-vector (vector-length a)
                (lambda (i) (+ (vector-ref a i) (vector-ref b i)))))

(define (vector- a b)
  (build-vector (vector-length a)
                (lambda (i) (- (vector-ref a i) (vector-ref b i)))))

(require rackunit)
(require rackunit/text-ui)

(define vector+--tests
  (test-suite
   "Test for vector+-"

   (check-equal? (vector+ (vector 1 2 3) (vector 3 2 1))
                 (vector 4 4 4))
   (check-equal? (vector- (vector 1 2 3) (vector 4 5 6))
                 (vector -3 -3 -3))
   ))

(exit (run-tests vector+--tests))
