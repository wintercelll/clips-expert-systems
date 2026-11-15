; Lab 1, task 5: find all men
(defrule find-men
   (person (name $?name) (gender male))
   =>
   (printout t "Man: " (implode$ ?name) crlf))
