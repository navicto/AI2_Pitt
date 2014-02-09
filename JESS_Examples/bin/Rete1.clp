(watch all)


(clear)
(reset)
(facts)

(deftemplate day
    (slot date)
    (slot humidity )
    (slot weather)
    (slot temperature))

(deftemplate person
    (slot name)
    (slot attitude))


(defrule rule1
    ?day <- (day (date ?date)(weather cloudy))
    =>
    (modify ?day (weather not-a-beachday)))

(defrule rule2
    ?day <- (day (date ?date)(weather sunny))
    =>
    (modify ?day (weather beachday)))

(defrule rule3
    (day (weather beachday))
    =>
    (assert (person (name Rebecca)(attitude happy))))

(view)

(assert (day (date Sept10)(temperature cool)))
(assert (day (date Sept12)(humidity low)))
(assert (day (date Sept14)(temperature hot)))
(assert (day (date Sept16)(weather sunny)))

(run)

(facts)