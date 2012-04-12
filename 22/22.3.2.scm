(define (whose-number phonebook number)
  (cond [(empty? phonebook) false]
        [(string=? (second (first phonebook)) number) (first (first phonebook))]
        [else (whose-number (rest phonebook) number)]))
(define (phone-number phonebook name)
  (cond [(empty? phonebook) false]
        [(string=? (first (first phonebook)) name) (second (first phonebook))]
        [else (phone-number (rest phonebook) name)]))



(define (make-lookup-phonebook phonebook)
  (local ((define (lookup-phonebook x)
            (local ((define result
                      (cond [(false? (string->number x)) (phone-number phonebook x)]
                            [else (whose-number phonebook x)])))
              (cond [(false? result) "Not found"]
                    [else result]))))
    lookup-phonebook))

(define phonebook
  (list
   (list "Matthias" "1234567")
   (list "Robert" "2345678")
   (list "Matthew" "3456789")
   (list "Shriram" "4567890")))
(define lookup-phonebook (make-lookup-phonebook phonebook))

(define entry (make-text ""))
(define a-msg (make-message "Welcome"))
(define a-btn
  (local ((define (show-lookup-result event)
            (draw-message a-msg (lookup-phonebook (text-contents entry)))))
    (make-button "Lookup" show-lookup-result)))

(create-window
 (list (list entry a-btn)
       (list a-msg)))
