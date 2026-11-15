; Lab 1, task 4: template person and fact list people
(deftemplate person
   (slot name)
   (slot age)
   (slot gender))

(deffacts people
   (person (name Danylo) (age 20) (gender male))
   (person (name Olena)  (age 19) (gender female))
   (person (name Ivan)   (age 45) (gender male)))
