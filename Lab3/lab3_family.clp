; Lab 3, task 1: family from Lab 2, output only with rules
; slot n is the number of the sentence, it sets the output order

(deftemplate parent-relation
   (slot n)
   (slot type (allowed-values father mother parents))
   (slot of)
   (multislot who))

(deftemplate family-role
   (slot n)
   (slot person)
   (slot role (allowed-values father mother son daughter)))

(deftemplate gender
   (slot n)
   (slot person)
   (slot sex (allowed-values male female)))

(deffacts family
   (step 1)
   (parent-relation (n 1) (type father)  (of John) (who Tom))
   (parent-relation (n 2) (type mother)  (of John) (who Susan))
   (parent-relation (n 3) (type parents) (of John) (who Tom Susan))
   (family-role (n 4) (person Tom)   (role father))
   (family-role (n 5) (person Susan) (role mother))
   (family-role (n 6) (person John)  (role son))
   (gender (n 7) (person Tom)   (sex male))
   (gender (n 8) (person Susan) (sex female))
   (gender (n 9) (person John)  (sex male)))

; The father of John is Tom. / The mother of John is Susan.
(defrule print-father-mother
   ?s <- (step ?n)
   (parent-relation (n ?n) (type ?t&father|mother) (of ?child) (who ?p))
   =>
   (printout t "The " ?t " of " ?child " is " ?p "." crlf)
   (retract ?s)
   (assert (step (+ ?n 1))))

; The parents of John are Tom and Susan.
(defrule print-parents
   ?s <- (step ?n)
   (parent-relation (n ?n) (type parents) (of ?child) (who ?p1 ?p2))
   =>
   (printout t "The parents of " ?child " are " ?p1 " and " ?p2 "." crlf)
   (retract ?s)
   (assert (step (+ ?n 1))))

; Tom is a father. / Susan is a mother. / John is a son.
(defrule print-role
   ?s <- (step ?n)
   (family-role (n ?n) (person ?p) (role ?r))
   =>
   (printout t ?p " is a " ?r "." crlf)
   (retract ?s)
   (assert (step (+ ?n 1))))

; Tom is a male. / Susan is a female. / John is a male.
(defrule print-gender
   ?s <- (step ?n)
   (gender (n ?n) (person ?p) (sex ?x))
   =>
   (printout t ?p " is a " ?x "." crlf)
   (retract ?s)
   (assert (step (+ ?n 1))))
