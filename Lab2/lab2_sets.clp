; Lab 2, task 2 (variant 1): sets
(deftemplate set
   (slot name)
   (slot description)
   (multislot elements)
   (slot subset-of (default none)))

(deffacts sets
   (set (name A) (description "numbers")
        (elements 1 2 3) (subset-of B))
   (set (name B) (description "numbers and colors")
        (elements 1 2 3 red green))
   (set (name C) (description "colors")
        (elements red green yellow blue)))

; check which set is really a subset of another one
(defrule find-subsets
   (set (name ?x) (elements $?ex))
   (set (name ?y&~?x) (elements $?ey))
   (test (subsetp $?ex $?ey))
   =>
   (printout t "Set " ?x " is a subset of set " ?y crlf))

; check that the subset-of slot is filled in correctly
(defrule check-subset-slot
   (set (name ?x) (elements $?ex) (subset-of ?y&~none))
   (set (name ?y) (elements $?ey))
   =>
   (if (subsetp $?ex $?ey)
      then (printout t "Slot subset-of for " ?x " is correct" crlf)
      else (printout t "Slot subset-of for " ?x " is wrong" crlf)))
