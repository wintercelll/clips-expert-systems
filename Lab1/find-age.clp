; Lab 1, task 5: find people with a certain age
(defrule find-age
   (person (name $?name) (age 45))
   =>
   (printout t "Age 45: " (implode$ ?name) crlf))
