; Lab 1, task 5: find a person with a certain name
(defrule find-name
   (person (name Olena Koval) (age ?age) (gender ?gender))
   =>
   (printout t "Found Olena Koval, age " ?age ", gender " ?gender crlf))
