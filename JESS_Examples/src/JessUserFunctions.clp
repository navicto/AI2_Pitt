;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; X. Defining your own functions

;; You define functions with the deffunction command - just like everything else it is a function with the command as the head.
;; You can use regular old control structures like If-Then, While and Foreach

(deffunction is-it-4 (?num)
	(if (eq ?num 4) 
		then (printout t "It is indeed 4!" crlf)
		else (printout t "Not 4." crlf)))


(is-it-4 2)   ;; call the function using the name of the function as the head of the list and the parameters as the other elements in the list
(is-it-4 4)

;; more useful control statements


(bind ?l (create$ apple apple banana plum apple peach apple))

(deffunction count-if-x (?x ?list)
	(bind ?iter 0)
	(bind ?count 0)
	(while (< ?iter (length$ ?list))
		(if (eq ?x (nth$ ?iter ?list))
			then (bind ?count (+ 1 ?count)))
		(bind ?iter (+ 1 ?iter)))
	(printout t "There are " ?count crlf))

(deffunction count-if-x-easier ( ?x ?list)
	(bind ?count 0)
	(foreach ?a ?list     ; foreach statement steps thru a list, so you do not need a separate iterator
		(if (eq ?a ?x)
		   then (bind ?count (+ 1 ?count))))
	(printout t "There are " ?count  crlf))

(count-if-x apple ?l)
(count-if-x-easier plum ?l)


