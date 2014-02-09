(clear)
(reset)

;(watch all)

(deftemplate bed
    (slot unit)
    (slot bed-number)
    (slot patient-name))

(deftemplate patient
    (slot patient-name)
    (multislot health-status))

(deffacts BadForBusiness
    (bed (unit ER)(patient-name Ann))
    (bed (unit ICU)(bed-number 1)(patient-name nil))
    (bed (unit ICU)(bed-number 2)(patient-name nil))
    (bed (unit Unit1)(bed-number 1)(patient-name nil))
    (bed (unit Unit1)(bed-number 2)(patient-name nil))
    (bed (unit Unit2)(bed-number 1)(patient-name nil))
    (bed (unit Unit2)(bed-number 2)(patient-name nil)))

(reset)
(facts)

(defrule ICUEmpty
    (bed (unit ICU)(bed-number 1)(patient-name nil))
    (bed (unit ICU)(bed-number 2)(patient-name nil))
    =>
    (printout t "The ICU is empty" crlf))

; What is the logical operator that is being used on the LHS?
; Why does this rule only get activated by one set of patterns?

(run)
