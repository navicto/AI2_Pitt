(clear)
(reset)

(watch all)


(deftemplate x (slot a))
(deftemplate y (slot b))
(deftemplate z (slot c))

;(assert (x (a hello)))

(defrule example-1
    (x (a ?v1))
    (x (a ?v1))
    =>)

(defrule example-2
    (x (a ?v1))
    (x (a ?v1))
    (z)
    =>)

(view)

(run)