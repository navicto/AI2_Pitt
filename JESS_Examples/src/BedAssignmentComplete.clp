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

(deffacts StartStateOnSlides
    (bed (unit ER)(patient-name Ann))
    (bed (unit ICU)(bed-number 1)(patient-name Barry))
    (bed (unit ICU)(bed-number 2)(patient-name Cleo))
    (bed (unit Unit1)(bed-number 1))
    (bed (unit Unit1)(bed-number 2)(patient-name Darren))
    (bed (unit Unit2)(bed-number 1)(patient-name Eva))
    (bed (unit Unit2)(bed-number 2)(patient-name Frank))
    (patient (patient-name Ann)(health-status very-ill))
    (patient (patient-name Barry)(health-status not-very-ill infectious))
    (patient (patient-name Cleo)(health-status infectious very-ill))
    (patient (patient-name Darren)(health-status not-very-ill))
    (patient (patient-name Eva)(health-status infectious not-very-ill))
    (patient (patient-name Frank)(health-status free2go))
    )

(reset)
(facts)

(defrule R3 "If patient is ready for discharge, then free the bed"
    ?patient-fact <- (patient (health-status $? free2go $?)(patient-name ?ptname))
    ?newbed-fact <- (bed (patient-name ?ptname)(unit ?unitname)(bed-number ?bedno))
    =>
    (retract ?patient-fact)
    (modify ?newbed-fact (patient-name nil))
	(printout t "R3 Fired. Patient " ?ptname " has been discharged, and " ?unitname " bed " ?bedno " is now free." crlf))


(defrule R1 "IF ER patient very ill and ICU bed free THEN admit to ICU bed"
    ?patient-fact <- (patient (patient-name ?ptname)(health-status $? very-ill $?))
    ?oldbed-fact <- (bed (patient-name ?ptname)(unit ER))
    ?newbed-fact <- (bed (patient-name nil)(unit ICU)(bed-number ?newbedno))
    =>
    (modify ?newbed-fact (patient-name ?ptname))
    (retract ?oldbed-fact)
    (printout t "R1 Fired. Patient " ?ptname " has been moved to ICU bed " ?newbedno " ." crlf))


(defrule R2 "IF there is a patient in an ICU bed who is not very ill and not infectious and there is a Unit 1 bed free THEN transfer to Unit 1 bed"
    (patient (health-status $?status)(patient-name ?ptname))
    (test (not (member$ infectious $?status)))
    (test (member$ not-very-ill $?status))
    ?oldbed-fact <- (bed (patient-name ?ptname)(unit ICU))
    ?newbed-fact <- (bed (patient-name nil) (unit Unit1)(bed-number ?bedno))
    =>
    (modify ?oldbed-fact (patient-name nil))
    (modify ?newbed-fact (patient-name ?ptname))
    (printout t "R2 Fired. Patient " ?ptname " has been moved to Unit1 bed " ?bedno "." crlf))


(defrule R4 "IF a patient is infectious and not very ill and there is a Unit 2 bed free THEN admit or transfer only to unit 2"
    (patient (health-status $?status)(patient-name ?ptname))
    (test (member$ infectious $?status))
    (test (member$ not-very-ill $?status))
    ?oldbed-fact <- (bed (patient-name ?ptname)(unit ER|ICU)) ; why (unit ER|ICU)?
    ?newbed-fact <- (bed (patient-name nil) (unit Unit2)(bed-number ?bedno))
    =>
    (modify ?oldbed-fact (patient-name nil))
    (modify ?newbed-fact (patient-name ?ptname)) 
    (printout t "R4 Fired. Patient " ?ptname " has been moved to Unit2 bed " ?bedno "." crlf))

(run)