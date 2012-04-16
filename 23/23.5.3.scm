(define (f x) (+ (* x x) (* -4 x) 7))
(graph-fun f 'black)

(define (line-from-point+slope point slope)
  (local ((define (f x)
            (+ (* slope x)
               (- (posn-y point)
                  (* slope (posn-x point))))))
         f))

(define (line-from-point+point p1 p2)
  (local ((define slope (/ (- (posn-y p2) (posn-y p1))
                           (- (posn-x p2) (posn-x p1)))))
         (line-from-point+slope p1 slope)))

(define (line-from-fun f x eps)
  (line-from-point+point (make-posn (- x eps) (f (- x eps)))
                         (make-posn (+ x eps) (f (+ x eps)))))

(define eps 2)
(graph-fun (line-from-fun f 2 eps) 'blue)
(graph-fun (line-from-fun f 2 (/ eps 2)) 'red)
(graph-fun (line-from-fun f 2 (/ eps 4)) 'black)
