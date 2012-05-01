(define (vector+ a b)
  (build-vector (vector-length a)
                (lambda (i) (+ (vector-ref a i) (vector-ref b i)))))

(define (vector- a b)
  (build-vector (vector-length a)
                (lambda (i) (- (vector-ref a i) (vector-ref b i)))))

(define (checked-vector+ a b)
  (cond [(= (vector-length a) (vector-length b)) (vector+ a b)]
        [else (error "checked-vector+: length of both vectors should be same.")]))

(define (checked-vector- a b)
  (cond [(= (vector-length a) (vector-length b)) (vector- a b)]
        [else (error "checked-vector-: length of both vectors should be same.")]))



(require rackunit)
(require rackunit/text-ui)

(define checked-vector+--tests
  (test-suite
   "Test for checked-vector+-"

   (check-equal? (checked-vector+ (vector 1 2 3) (vector 3 2 1))
                 (vector 4 4 4))
   (check-exn exn? (lambda () (checked-vector+ (vector 1 2 3) (vector 3 2))))
   (check-exn exn? (lambda () (checked-vector+ (vector 1 2) (vector 3 2 3))))
   (check-equal? (checked-vector- (vector 1 2 3) (vector 4 5 6))
                 (vector -3 -3 -3))
   (check-exn exn? (lambda () (checked-vector- (vector 1 2 3) (vector 3 2))))
   (check-exn exn? (lambda () (checked-vector- (vector 1 2 3) (vector 3 2 4 5))))
   ))

(exit (run-tests checked-vector+--tests))
