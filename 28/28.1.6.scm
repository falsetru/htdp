(define (find-route origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define (find-route/list lo-Os)
                    (cond
                      [(empty? lo-Os) false]
                      [else (local ((define possible-route (find-route (first lo-Os) destination G)))
                                   (cond
                                     [(boolean? possible-route) (find-route/list (rest lo-Os))]
                                     [else possible-route]))]))
                  (define (neighbors orig g)
                    (second (assoc orig g)))
                  (define possible-route 
                    (find-route/list (neighbors origination G))))
                 (cond
                   [(boolean? possible-route) false]
                   [else (cons origination possible-route)]))]))



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
