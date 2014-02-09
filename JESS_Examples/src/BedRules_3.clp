(clear)
(reset)

(watch all)

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

(defrule FindEmptyBeds
    (bed (unit ?unit)(bed-number ?bedno)(patient-name nil))
    =>
    (printout t ?unit " bed number " ?bedno " is empty."crlf))


(run)
