; Lab 1, task 3: simple rule
; (deffacts from lab1_days.clp must be loaded too)
(defrule what-day
   (Today is ?day)
   =>
   (printout t "Today is " ?day crlf))
