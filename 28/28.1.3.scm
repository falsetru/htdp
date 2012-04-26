(define (neighbors orig g)
  (second (assoc orig g)))

(define (find-route origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
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
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define find-route-tests
  (test-suite
   "Test for find-route"

   (check-equal? (find-route 'A 'G Graph) '(A B E F G))
   (check-equal? (find-route 'C 'G Graph) false)
   ))

(exit (run-tests find-route-tests))
