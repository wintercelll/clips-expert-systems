; Lab 1, task 4*: template with multislot, type and allowed-values
(deftemplate person
   (multislot name)
   (slot age (type INTEGER))
   (slot gender (allowed-values male female)))

(deffacts people
   (person (name Danylo Vikhtenko) (age 20) (gender male))
   (person (name Olena Koval)      (age 19) (gender female))
   (person (name Ivan Petrenko)    (age 45) (gender male))
   (person (name Maria Bondar)     (age 45) (gender female)))
