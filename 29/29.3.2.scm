(define (neighbors orig graph)
  (vector-ref graph orig))

(define (find-route origination destination G)
  (cond
    [(= origination destination) (list destination)]
    [else (local ((define possible-route 
		    (find-route/list (neighbors origination G) destination G)))
	    (cond
	      [(boolean? possible-route) false]
	      [else (cons origination possible-route)]))]))

(define (find-route/list lo-Os D G)
  (cond
    [(empty? lo-Os) false]
    [else (local ((define possible-route (find-route (first lo-Os) D G)))
	    (cond
	      [(boolean? possible-route) (find-route/list (rest lo-Os) D G)]
	      [else possible-route]))]))


(require rackunit)
(require rackunit/text-ui)

(define Graph 
  (vector '(1 4)
          '(4 5)
          '(3)
          '()
          '(2 5)
          '(3 6)
          '()))

(define find-route-tests
  (test-suite
   "Test for find-route"

   (check-equal? (find-route 0 6 Graph) '(0 1 4 5 6))
   (check-equal? (find-route 2 6 Graph) false)
   (time
     (for-each
       (lambda (i) (find-route 0 4 Graph))
       (build-list 10000 identity)))
   ))

(exit (run-tests find-route-tests))
