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

;(defrule EmptyUnit1
;    (bed (unit ?unit)(bed-number 1)(patient-name nil))
;    (bed (unit ?unit)(bed-number 2)(patient-name nil))
;    =>
;    (printout t ?unit " is empty." crlf))

; this is exactly the same as

(defrule EmptyUnit2
    (and (bed (unit ?unit)(bed-number 1)(patient-name nil))
         (bed (unit ?unit)(bed-number 2)(patient-name nil)))
    =>
    (printout t ?unit " is empty." crlf))

; What will happen if you replace the 'and' with 'or'?
; How is the 'not' pattern different than 'and' or 'or'?

(run)
