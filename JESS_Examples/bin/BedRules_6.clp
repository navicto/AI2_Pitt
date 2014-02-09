(clear)
(reset)


(deftemplate bed
    (slot unit)
    (slot bed-number)
    (slot patient-name))

(deftemplate patient
    (slot patient-name)
    (multislot health-status))

; Here we have changed to starting with our Start State from last week for Bed Assignment

(deffacts StartStateOnSlides
    (bed (unit ER)(patient-name Ann))
    (bed (unit ICU)(bed-number 1)(patient-name Barry))
    (bed (unit ICU)(bed-number 2)(patient-name Cleo))
    (bed (unit Unit1)(bed-number 1))
    (bed (unit Unit1)(bed-number 2)(patient-name Darren))
    (bed (unit Unit2)(bed-number 1)(patient-name Eva))
    (bed (unit Unit2)(bed-number 2)(patient-name Frank))
    (patient (patient-name Ann)(health-status very-ill))
    (patient (patient-name Barry)(health-status infectious not-very-ill))
    (patient (patient-name Cleo)(health-status infectious very-ill))
    (patient (patient-name Darren)(health-status not-very-ill))
    (patient (patient-name Eva)(health-status infectious not-very-ill))
    (patient (patient-name Frank)(health-status free2go))
    )

(reset)
(facts)

; Why doesn't this rule work?

(defrule BuggyFindNotInfectiousPatient
   (patient (health-status $? ~infectious $?)(patient-name ?ptname))
    =>
	(printout t "Patient " ?ptname " is not infectious." crlf))







; Instead let's implement it using a predicate function constraint

        
;(defrule FindNotInfectiousPatient
;    (patient (health-status $?status&:(not (member$ infectious $?status)))(patient-name ?ptname))
;    =>
;	(printout t "Patient " ?ptname " is not infectious." crlf))

(run)