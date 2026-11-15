; Lab 2, task 1: family facts
; group 1: who is the father / mother / parents of someone
(deftemplate parent-relation
   (slot type (allowed-values father mother parents))
   (slot of)
   (multislot who))

; group 2: role of a person in the family
(deftemplate family-role
   (slot person)
   (slot role (allowed-values father mother son daughter)))

; group 3: gender of a person
(deftemplate gender
   (slot person)
   (slot sex (allowed-values male female)))

(deffacts family
   (parent-relation (type father)  (of John) (who Tom))
   (parent-relation (type mother)  (of John) (who Susan))
   (parent-relation (type parents) (of John) (who Tom Susan))
   (family-role (person Tom)   (role father))
   (family-role (person Susan) (role mother))
   (family-role (person John)  (role son))
   (gender (person Tom)   (sex male))
   (gender (person Susan) (sex female))
   (gender (person John)  (sex male)))

; small check: print all facts about John's parents
(defrule show-parents
   (parent-relation (type ?t) (of ?child) (who $?p))
   =>
   (printout t "The " ?t " of " ?child ": " (implode$ ?p) crlf))
