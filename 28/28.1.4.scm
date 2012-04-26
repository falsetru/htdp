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

(define (test-on-all-nodes g)
  (local ((define node-list (map first g)))
         (foldr append empty
                (map (lambda (orig) (wander orig node-list g)) node-list))))

(define (wander orig dests g)
  (map (lambda (d) (list orig d (find-route orig d g)))
       dests))

(define Graph 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(for-each
  (lambda (x) (printf "~s -> ~s: ~s\n"
                      (first x)
                      (second x)
                      (third x)))
  (test-on-all-nodes Graph))
