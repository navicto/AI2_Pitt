(import java.util.Calendar)
(import java.util.Arrays)

;Rule-based reminder system
;Obesity Guideline:
;	http://healthit.ahrq.gov/health-it-tools-and-resources/pediatric-rules-and-reminders/how-read-pediatric-reminderguideline-document
;ADHD Guideline:
;	http://healthit.ahrq.gov/health-it-tools-and-resources/pediatric-rules-and-reminders/adhd-last-adhd-visit-6-months-overdue-follow
;Chlamydia Guideline:
;	http://healthit.ahrq.gov/health-it-tools-and-resources/pediatric-rules-and-reminders/%20chlamydia-ocp-medication-list-and-last-screen-12-months-due-chlamydia-screen

(clear)

(deftemplate Patient
    (slot patient_id)
    (slot age)
    (slot gender)
    (slot BMI)
    (slot date_BMI)
    (slot date_LDL)
    (slot date_total_chol)
    (slot date_height)
    (slot date_weight)
    (slot date_chlamydia_test)
    (multislot problem_list)
    (multislot current_meds)
    (slot date_ADHD_review)
    )

(deftemplate TriggersObesity
    (multislot age_range)
    (slot max_BMI)
    (slot time_delta_LDL)
    (slot time_delta_chol)
    (slot time_delta_height)
    (slot time_delta_weight)
    (slot time_delta_BMI)
    )

(deftemplate TriggersADHD
    (multislot age_range)
    (multislot disorders)
    (multislot meds)
    (slot time_delta_ADHD)
    )

(deftemplate TriggersChlamydia
    (slot risk_gender)
    (slot age_limit)
    (slot time_delta_chlamydia)
    (multislot meds)
    )

(deftemplate Today
    (slot date_in_millis)
    )

(deffunction get_date ()
    (bind ?calendar (Calendar.getInstance))
    (bind ?date_in_millis (?calendar getTimeInMillis))
	(return ?date_in_millis)
    )

(deffunction months_2_milliseconds(?milliseconds)
    (bind ?months (* 30.4375 24 60 60 1000 ?milliseconds))
    (return ?months)
    )

(deffunction list_contains(?list ?look_for)
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

(deffacts Patients
    (TriggersObesity (age_range 10 18)(max_BMI 95)(time_delta_LDL (months_2_milliseconds 24))
        (time_delta_chol (months_2_milliseconds 24))(time_delta_BMI (months_2_milliseconds 24))
        (time_delta_height (months_2_milliseconds 24))(time_delta_weight (months_2_milliseconds 24)))

    (TriggersADHD (age_range 6 18)(disorders ADHD ADD)(meds methylphenidate dextroamphetamine mixed-salt-amphetamine atomoxetine)(time_delta_ADHD (months_2_milliseconds 6)))

    (TriggersChlamydia (age_limit 26)(risk_gender female)(time_delta_chlamydia (months_2_milliseconds 12))
        (meds "ALESSE" "APRI" "AVIANE" "BREVICON" "CAMILA" "CYCLESSA" "DEMULEN 1/35" "DEMULEN 1/50" "DESOGEN" "ERRIN" "ESTROSTEP 21" "ESTROSTEP FE" "ETHINYL ESTRADIOL/NORETHINDRONE ACETATE" "ETHINYL ESTRADIOL/NORETHINDRONE ACETATE/FE" "LESSINA" "LEVLEN" "LEVLITE-21" "LEVLITE-28" "LEVONORGESTREL INTRAUTERINE SYSTEM" "LEVORA 0.15/30" "LEVORA 0.15/30-21" "LEVORA 0.15/30-28" "LO/OVRAL" "LOESTRIN 21 1.5/30" "LOESTRIN 21 1/20" "LOESTRIN FE 1.5/30" "LOESTRIN FE 1/20" "LO-OVRAL" "LOW-OGESTREL (28)" "MEDROXYPROGESTERONE" "MEDROXYPROGESTERONE INJ" "MICROGESTIN FE 1.5/30" "MICROGESTIN FE 1/20" "MIRCETTE" "MIRENA INTRAUTERINE SYSTEM" "MODICON" "NECON 0.5/35" "NECON 0.5/35-21" "NECON 1/35" "NECON 1/50" "NECON 10/11" "NORDETTE" "NORETHIN 1/35E" "NORETHIN 1/50M" "NORETHINDRONE ACETATE" "NORGESTREL" "NORGESTREL 0.5MG/ETHINYL ESTRADIOL 0.05MG" "NORINYL 1 + 50" "NORINYL 1+35" "NORINYL 1+50" "NOR-Q-D" "NUVARING" "ORTHO EVRA" "ORTHO MICRONOR" "ORTHO TRI-CYCLEN" "ORTHO TRI-CYCLEN LO" "ORTHO-CEPT" "ORTHO-CYCLEN" "ORTHO-NOVUM 1/35" "ORTHO-NOVUM 1/50" "ORTHO-NOVUM 10/11" "ORTHO-NOVUM 7/7/7" "OVCON-35" "OVCON-50" "OVRAL (MORNING AFTER PILL)" "OVRAL-21" "OVRAL-28" "PLAN B" "PORTIA" "SEASONALE" "TRI-LEVLEN" "TRI-NORINYL" "TRIPHASIL" "TRIVORA" "YASMIN" "ZOVIA 1/35" "ZOVIA 1/50"))

    
    ;Patient 1: Obesity reminder --> within age; BMI above threshold; weight, height and BMI measures within 24 months; LDL and cholesterol older than 24 months 
    (Patient (patient_id p01)(age 11)(BMI 98)(date_LDL (-(get_date) (months_2_milliseconds 25)))
        (date_total_chol (-(get_date) (months_2_milliseconds 25)))(date_height (-(get_date) (months_2_milliseconds 23)))
        (date_weight (-(get_date) (months_2_milliseconds 23)))(date_BMI (-(get_date) (months_2_milliseconds 23))))
    
    ;Patient 2: ADHD reminder --> within age; ADHD in problem list; atomoxetine in meds list; last ADHD review older than 6 months
    (Patient (patient_id p02)(age 6)(problem_list flu ADHD)(date_ADHD_review (-(get_date)(months_2_milliseconds 7)))(current_meds aspirine atomoxetine))
    
    ;Patient 3: ADHD reminder --> within age; ADD in problem list; no relevant meds; last ADHD review older than 6 months
    (Patient (patient_id p03)(age 6)(problem_list flu ADD)(date_ADHD_review (-(get_date)(months_2_milliseconds 7)))(current_meds aspirine))
    
    ;Patient 4: ADHD reminder --> within age; no relevant problems; mixed-salt-amphetamine in meds; last ADHD review older than 6 months
    (Patient (patient_id p04)(age 6)(problem_list flu diabetes)(date_ADHD_review (-(get_date)(months_2_milliseconds 7)))(current_meds aspirine mixed-salt-amphetamine))
    
    ;Patient 5: No reminder --> outside age range; ADHD in problem list; atomoxetine in meds list; last ADHD review older than 6 months
    (Patient (patient_id p05)(age 27)(problem_list flu ADHD)(date_ADHD_review (-(get_date)(months_2_milliseconds 7)))(current_meds aspirine atomoxetine))
    
    ;Patient 6: No reminder --> within age; ADHD in problem list; atomoxetine in meds list; last ADHD review 4 months ago
    (Patient (patient_id p05)(age 6)(problem_list flu ADHD)(date_ADHD_review (-(get_date)(months_2_milliseconds 4)))(current_meds aspirine atomoxetine))
    
    ;Patient 7: Chlamydia reminder --> female; within age; last recorded chlamydia over a year ago; APRI present in meds 
    (Patient (patient_id p07)(age 22)(gender female)(current_meds aspirine APRI)(date_chlamydia_test (-(get_date)(months_2_milliseconds 13))))
    
    ;Patient 8: No reminder --> female; outside age range; last recorded chlamydia over a year ago; APRI present in meds 
    (Patient (patient_id p08)(age 28)(gender female)(current_meds aspirine APRI)(date_chlamydia_test (-(get_date)(months_2_milliseconds 13))))
    
    ;Patient 9: No reminder --> female; within age; last recorded chlamydia over a year ago; No relevant meds 
    (Patient (patient_id p09)(age 22)(gender female)(current_meds aspirine)(date_chlamydia_test (-(get_date)(months_2_milliseconds 13))))
    
    ;Patient 10: Chlamydia reminder --> female; within age; last recorded chlamydia over a year ago; CYCLESSA and APRI in meds list
    (Patient (patient_id p10)(age 22)(gender female)(current_meds aspirine CYCLESSA APRI)(date_chlamydia_test (-(get_date)(months_2_milliseconds 13))))
    
    ;Patient 11: Obesity and ADHD reminders --> within age; BMI above threshold; weight, height and BMI measures within 24 months; 
;    	LDL and cholesterol older than 24 months; ADHD in problem list; last ADHD review over 6 months ago 
    (Patient (patient_id p11)(age 11)(BMI 98)(date_LDL (-(get_date) (months_2_milliseconds 25)))
        (date_total_chol (-(get_date) (months_2_milliseconds 25)))(date_height (-(get_date) (months_2_milliseconds 23)))
        (date_weight (-(get_date) (months_2_milliseconds 23)))(date_BMI (-(get_date) (months_2_milliseconds 23)))
        (problem_list flu ADHD)(date_ADHD_review (-(get_date)(months_2_milliseconds 7))))
    
    ;Patient 12: Obesity and ADHD reminders --> within age; BMI above threshold; weight, height and BMI measures within 24 months; 
;    	LDL and cholesterol older than 24 months; none known problems; last ADHD review over 6 months ago; methylphenidate in meds list
    (Patient (patient_id p12)(age 11)(BMI 98)(date_LDL (-(get_date) (months_2_milliseconds 25)))
        (date_total_chol (-(get_date) (months_2_milliseconds 25)))(date_height (-(get_date) (months_2_milliseconds 23)))
        (date_weight (-(get_date) (months_2_milliseconds 23)))(date_BMI (-(get_date) (months_2_milliseconds 23)))
        (current_meds methylphenidate)(date_ADHD_review (-(get_date)(months_2_milliseconds 7))))
    
    ;Patient 13: ADHD and Chlamydia reminders --> within age; female; ADHD in problem list; 
    ;atomoxetine and ALESSE in meds list; last ADHD review older than 6 months
    (Patient (patient_id p13)(gender female)(age 6)(problem_list flu ADHD)(date_ADHD_review (-(get_date)(months_2_milliseconds 7)))
        (current_meds aspirine atomoxetine ALESSE)(date_chlamydia_test (-(get_date)(months_2_milliseconds 13))))
    
    ;Patient 14: Obesity and Chlamydia reminders --> within age; BMI above threshold; weight, height and BMI measures within 24 months;
    ;LDL and cholesterol older than 24 months; female; ALESSE in meds list; last chlamydia test over a year ago 
    (Patient (patient_id p14)(age 16)(BMI 98)(date_LDL (-(get_date) (months_2_milliseconds 25)))
        (date_total_chol (-(get_date) (months_2_milliseconds 25)))(date_height (-(get_date) (months_2_milliseconds 23)))
        (date_weight (-(get_date) (months_2_milliseconds 23)))(date_BMI (-(get_date) (months_2_milliseconds 23)))
        (current_meds aspirine ALESSE)(date_chlamydia_test (-(get_date)(months_2_milliseconds 13)))(gender female))
    
    ;Patient 15: No reminders --> outside age range; BMI above threshold; weight, height and BMI measures within 24 months; LDL and cholesterol older than 24 months 
    (Patient (patient_id p15)(age 27)(BMI 98)(date_LDL (-(get_date) (months_2_milliseconds 25)))
        (date_total_chol (-(get_date) (months_2_milliseconds 25)))(date_height (-(get_date) (months_2_milliseconds 23)))
        (date_weight (-(get_date) (months_2_milliseconds 23)))(date_BMI (-(get_date) (months_2_milliseconds 23))))
   
    
    
    (Today (date_in_millis (get_date)))
    )

(defrule Obesity
    (Today (date_in_millis ?date_in_millis)) ;load today's date
    (TriggersObesity (max_BMI ?max_BMI)(time_delta_LDL ?time_delta_LDL);load triggers
        (time_delta_chol ?time_delta_chol)(time_delta_height ?time_delta_height)
        (time_delta_weight ?time_delta_weight)(age_range ?min_age ?max_age)
        (time_delta_BMI ?time_delta_BMI)(time_delta_height ?time_delta_height)(time_delta_weight ?time_delta_weight)
        )
    (Patient 
        (patient_id ?patient_id)(age ?age&:(and (>= ?age ?min_age)(<= ?age ?max_age)))
        (BMI ?BMI&:(> ?BMI ?max_BMI))
        (date_total_chol ?chol&:(>= (- ?date_in_millis ?chol) ?time_delta_chol))
        (date_LDL ?LDL&:(>= (- ?date_in_millis ?LDL) ?time_delta_LDL))
        (date_BMI ?date_BMI&:(< (- ?date_in_millis ?date_BMI) ?time_delta_BMI))
        (date_BMI ?date_height&:(< (- ?date_in_millis ?date_height) ?time_delta_height))
        (date_BMI ?date_weight&:(< (- ?date_in_millis ?date_weight) ?time_delta_weight))
        )
    =>
    (printout t ?patient_id"Õs BMI >95%. Consider lipid profile every 1 to 2 years" crlf)
    )

(defrule ADHD
    (Today (date_in_millis ?date_in_millis))
    (TriggersADHD (age_range ?min_age ?max_age)(time_delta_ADHD ?time_delta_ADHD)(disorders $?disorders)(meds $?meds))
    (Patient
        (patient_id ?patient_id)(age ?age&:(and (>= ?age ?min_age)(<= ?age ?max_age)))
        (current_meds $?current_meds)(problem_list $?problem_list&:(or (= TRUE (list_contains ?problem_list ?disorders))(= TRUE (list_contains ?current_meds ?meds))))
        (date_ADHD_review ?date_ADHD_review&:(> (- ?date_in_millis ?date_ADHD_review) ?time_delta_ADHD ))
        )
    =>
    (printout t ?patient_id " has ADHD: medication/symptom follow-up recommended every 3-6 months" crlf)
    )

(defrule Chlamydia
    (Today (date_in_millis ?date_in_millis)) ;load today's date
    (TriggersChlamydia (age_limit ?age_limit)(meds $?meds)(risk_gender ?risk_gender)(time_delta_chlamydia ?time_delta_chlamydia))
    (Patient
        (gender ?gender&:(= ?gender ?risk_gender))
        (age ?age&:(< ?age ?age_limit))
        (date_chlamydia_test ?date_chlamydia_test&:(>(- ?date_in_millis ?date_chlamydia_test) ?time_delta_chlamydia))
        (current_meds $?current_meds&:(list_contains ?current_meds ?meds))
        (patient_id ?patient_id)
        )
    =>
    (printout t ?patient_id": Contraceptive is on medication list.  If patient is sexually active, screen for Chlamydia." crlf)
    )
(reset)
(facts)
(watch all)
(run)
