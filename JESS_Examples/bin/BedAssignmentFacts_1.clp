(clear)
(reset)

(deftemplate bed
    (slot unit)
    (slot bed-number)
    (slot patient-name))

(deftemplate patient
    (slot patient-name)
    (multislot health-status)
    (slot unit)
    (slot bed-number))

; Assert

(assert (bed (unit ER)(patient-name Ann)))
(facts)

;(watch all)

;(bind ?fact (assert (bed (unit ER)(patient-name Barry))))   
;(facts)
;(retract ?fact)
;(facts)

