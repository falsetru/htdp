(define Graph 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))


(define Cyclic-Graph 
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define Cycle+Lonely-Node
  '((A (B))
    (B (C))
    (C (A))
    (D (D))))

(define (contains x xs)
  (cons? (memq x xs)))

(define (neighbors orig g)
  (second (assoc orig g)))

(define (find-route origination destination G)
  (find-route-aux origination destination G empty))

(define (find-route-aux origination destination G seen)
  (cond
    [(symbol=? origination destination) (list destination)]
    [(contains origination seen) false]
    [else (local ((define possible-route 
		    (find-route/list (neighbors origination G) destination G
                                     (cons origination seen))))
	    (cond
	      [(boolean? possible-route) false]
	      [else (cons origination possible-route)]))]))

(define (find-route/list lo-Os D G seen)
  (cond
    [(empty? lo-Os) false]
    [else (local ((define possible-route (find-route-aux (first lo-Os) D G seen)))
	    (cond
	      [(boolean? possible-route) (find-route/list (rest lo-Os) D G seen)]
	      [else possible-route]))]))


(require rackunit)
(require rackunit/text-ui)

(define find-route-tests
  (test-suite
   "Test for find-route"

   (check-equal? (find-route 'A 'G Graph) '(A B E F G))
   (check-equal? (find-route 'C 'G Graph) false)
   (check-equal? (find-route 'B 'G Cyclic-Graph) '(B E F G))
   (check-equal? (find-route 'B 'D Cycle+Lonely-Node) false)
   ))

(exit (run-tests find-route-tests))
