(clear)
(reset)

;(watch all))

(deftemplate bed
    (slot unit)
    (slot bed-number)
    (slot patient-name))

(deftemplate patient
    (slot patient-name)
    (multislot health-status))

(deffacts BadForBusiness
    (bed (unit ER)(patient-name Ann))
    (bed (unit ICU)(bed-number 1)(patient-name Ann2))
    (bed (unit ICU)(bed-number 2)(patient-name Ann3))
    (bed (unit Unit1)(bed-number 1)(patient-name Ann4))
    (bed (unit Unit1)(bed-number 2)(patient-name Ann5))
    (bed (unit Unit2)(bed-number 1)(patient-name Ann6))
    (bed (unit Unit2)(bed-number 2)(patient-name Ann7)))

(reset)
(facts)

(defrule HospitalNotFull
    (bed (patient-name nil))
    =>
    (printout t "The hospital is not full" crlf))

; Why does this rule fire 6 times? Use (Watch All). What does (exists) do?
; What happens when we (run 1)

(defrule HospitalFull
    (not(bed (patient-name nil)))
    =>
    (printout t "The hospital is full" crlf)
    )

(defrule Unit2Bed
    ?bed-fact <- (bed (patient-name ?name))
    =>
    (printout t ?name crlf)
    )

(run)

