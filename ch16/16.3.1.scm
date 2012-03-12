(define-struct file (name size content))
(define-struct dir (name dirs files))


(define Text (make-dir 'Text
                       empty
                       (list (make-file 'part1 99 empty)
                             (make-file 'part2 52 empty)
                             (make-file 'part3 17 empty))))
(define Code (make-dir 'Code
                       empty
                       (list (make-file 'hang 8 empty)
                             (make-file 'draw 2 empty))))
(define Docs (make-dir 'Docs
                       empty
                       (list (make-file 'read! 19 empty))))
(define Libs (make-dir 'Libs
                       (list Code Docs)
                       empty))
(define TS   (make-dir 'TS
                       (list Text Libs)
                       (list (make-file 'read! 10 empty))))
