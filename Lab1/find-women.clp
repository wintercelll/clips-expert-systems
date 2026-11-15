; Lab 1, task 5: find all women
(defrule find-women
   (person (name $?name) (gender female))
   =>
   (printout t "Woman: " (implode$ ?name) crlf))
