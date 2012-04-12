(define pad
  '((1 2 3)
    (4 5 6)
    (7 8 9)
    (\# 0 *)))

(define pad2 
  '((1 2 3  +)
    (4 5 6  -)
    (7 8 9  *)
    (0 = \. /)))

(define (cell->string cell)
  (cond [(number? cell) (number->string cell)]
        [(symbol? cell) (symbol->string cell)]))

(define (pad->gui title gui-table)
  (local ((define t (make-message title))
          (define msg (make-message ""))
          (define items
            (map (local ((define (make-gui-item cell)
                           (local ((define txt (cell->string cell))
                                   (define (draw-txt event) (draw-message msg txt)))
                             (make-button txt draw-txt)))
                         (define (make-gui-items-row row)
                           (map make-gui-item row)))
                   make-gui-items-row) gui-table))
          (define gui-items
            (append (list (list t)
                          (list msg))
                    items)))
    (create-window gui-items)))

(pad->gui "Virtual Phone" pad)
(pad->gui "Calculator" pad2)
