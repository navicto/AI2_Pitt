(clear)
(import java.util.Calendar)
(bind ?calendar (Calendar.getInstance))
(bind ?date_in_millis (?calendar getTimeInMillis))
(printout t ?date_in_millis crlf)


(import java.util.Arrays)
;(bind ?jess_list (create$ a b c))
;(bind ?java_list (Arrays.asList ?jess_list))
;(bind ?result (?java_list contains d))
;(printout t ?result crlf)


;(bind ?list (create$ a b c d))
;(foreach ?x ?list 
;    (printout t ?x crlf)
;    )


(deffunction compare(?list ?look_for)
    (bind ?java_list (Arrays.asList ?list))
    (bind ?java_look_for (Arrays.asList ?look_for))
    (foreach ?x ?java_look_for
        (bind ?match (?java_list contains ?x))
        (if (= ?match TRUE) then
            (return TRUE)
            )
        )
    (return FALSE)
    )

(bind ?list (create$ a b c d))
(bind ?list2 (create$ t y))
(bind ?find (compare ?list ?list2))
(printout t ?find crlf)