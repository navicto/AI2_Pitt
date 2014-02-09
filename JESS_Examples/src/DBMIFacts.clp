(clear)
(reset)

;; An example of defining unordered facts using deftemplate - in this case with extension
(deftemplate person
    (slot name)
    (slot gender))

(deftemplate DBMIperson extends person
    (slot job)
    (slot location (default Parkvale)))

(deftemplate DBMIfaculty extends DBMIperson
    (multislot interests))


;;Asserting and modifying facts based on those templates

(bind ?a (assert (DBMIfaculty (name MikeBecich)(gender Male)(job Chair)(interests CRI CTSA imaging NextGenSequencing))))
(facts)
(modify ?a (interests  CRI imaging NextGenSequencing))
(facts)

