;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; VII. Lists
;;
;; The basic unit of structure in Jess is the list
;; A list consists of one or more tokens enclosed by parens
;; Lists are multifields, and you can manipulate them using the multifield functions
;; When the head of the list is a function name - Jess will use that function and the remaining elements as parameters)
;; If the head of the list is not a valid function name (one of jess's or one you define) -Jess will give you an error
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(a b c)  ; this should produce an error because there is no user defined or Jess function 'a'
(+ 4 3)  ; In this case the list is a valid function call because + is a defined Jess function - type this into the Jess Console and evaluate it.

(bind ?shopping-list (create$ apple banana peach))
(printout t "shopping-list is: " ?shopping-list crlf)

(bind ?first-thing-on-list(first$ (create$ a b c))) ; In this case we've created a list (a b c) and then returned a list consisting of only the first element
(printout t "first-thing-on-list is: " ?first-thing-on-list crlf)
(printout t "without the list: " (nth$ 1 ?first-thing-on-list ) crlf)

(bind ?rest-of-list (rest$ (create$ a b c))) ; In this case we've created a list (a b c) and then returned a list consisting of only the rest of the list
(printout t "rest-of-list is: " ?rest-of-list crlf)