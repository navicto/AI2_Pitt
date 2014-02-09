;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IX. Variables - single symbol
;;
;; Variables are bound using the (bind) statement
;; When you bind a variable to atoms, strings and numbers, make the variable name ?X or ?Y or ?Whatever


(bind ?a apple)				; see what happens now when you evaluate ?a ?b and ?c
(bind ?b "banana")
(bind ?c 4)
(printout t ?a " and "?b " and "?c)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IX. Variables - lists

;; Lists are created using (create$)
;; When you bind a variable to a list you have to do two things differently
;; You have to create the list using (create$) function
;; You may want name the variable $?X $?Y or $?Whatever

(bind $?a (create$ a b c))  

; see what happens now when you evaluate ?a

(printout t ?a)

(bind ?a 4)
(bind ?b 5)
(bind ?answer (< ?a ?b))    

; see what happens now when you evaluate ?answer

(printout t ?answer)


;;There are lots and lots of built in Jess functions for manipulating these multivariables and they all end in $

(bind ?ListOne (create$ a b c d e f))
(bind ?ListTwo (create$ d e f g h i))
(length$ ?ListOne)
(first$ ?ListOne)
(rest$ ?ListOne)
(nth$ 3 ?ListOne)
(insert$ ?ListOne 4 ?ListTwo)
(member$ c ?ListOne )
(intersection$ ?ListOne ?ListTwo)
(union$ ?ListOne ?ListTwo)
