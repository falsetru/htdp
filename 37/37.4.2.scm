;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.4.2) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
(define queue empty)
(define (enter item) (set! queue (append queue (list item))))
(define (next) (cons? queue))
(define (rm)
  (local ((define result (first queue)))
    (cond [(next)
           (begin
             (set! queue (rest queue))
             result)]
          [else (error 'rm "Queue is empty")])))
(define (count) (length queue))


(define msg (make-message "Welcome to the Task Manager"))
(define msg-count (make-message "2000"))
(define task-entry (make-text ""))
(define btn-enter
  (make-button
   "Enter"
   (lambda (e)
     (begin
       (enter (text-contents task-entry))
       (draw-message msg-count (number->string (count)))
       ))))
(define btn-next
  (make-button
   "Next"
   (lambda (e)
     (cond [(next)
            (begin
              (draw-message msg (rm))
              (draw-message msg-count (number->string (count))))]
           [else true]))))
(define btn-quit
  (make-button
   "Quit"
   (lambda (e) (hide-window win))))


(define win
  (create-window
   (list (list msg msg-count)
         (list (make-message "Task:")
               task-entry
               btn-enter)
         (list btn-next btn-quit))))