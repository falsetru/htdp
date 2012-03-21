(define-struct dir (name content))

(define Text (make-dir 'Text (list 'part1 'part2 'part3)))
(define Code (make-dir 'Code (list 'hang 'draw)))
(define Docs (make-dir 'Docs (list 'read!)))
(define Libs (make-dir 'Libs (list Code Docs)))
(define TS   (make-dir 'TS (list Text Libs 'read!)))
