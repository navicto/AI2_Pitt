;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; VIII. Jess Functions
;;
;; Jess has alot of built in functions and they all look like lists
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(create$ apple banana peach)
(first$ (create$ a b c))
(printout  t "Hello World" crlf)
(eq 1 1)
(< 1 2)

;; functions are evaluated from the inside out

(< (+ 1 1)(+ 2 2))

(eq 4 (+ 2 2))
