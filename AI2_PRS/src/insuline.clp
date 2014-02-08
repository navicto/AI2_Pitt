(clear)

(deftemplate glucose
    (slot level))

(defrule insulin
    (glucose (level ?glucose))
    =>
    (if (and (>= ?glucose 70)(<= ?glucose 100)) then
        (bind ?dose 5)
	elif (and (>= ?glucose 101)(<= ?glucose 150)) then
        (bind ?dose 6)
    elif (and (>= ?glucose 151)(<= ?glucose 200)) then
        (bind ?dose 7)
    elif (and (>= ?glucose 201)(<= ?glucose 250)) then
        (bind ?dose 8)
    elif (and (>= ?glucose 251)(<= ?glucose 300)) then
        (bind ?dose 9)
    elif (> ?glucose 300) then
        (bind ?dose 10)
        )
    (printout t "Insulin dosage recommendation: "?dose crlf)
    )

(assert (glucose (level 151)))
(facts)
(run)