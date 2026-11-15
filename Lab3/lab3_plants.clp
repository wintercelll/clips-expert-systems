; Lab 3, task 2 (variant 1): nutrient deficiency of a plant

; color of the plant, a healthy plant is green
(deftemplate plant
   (slot color (allowed-values green pale-yellow purplish) (default green)))

; one symptom of the plant
(deftemplate symptom
   (slot type (allowed-values stunted-growth reddish-brown-leaf-edges
                              stunted-root-growth spindly-stalk delayed-maturing
                              scorched-leaf-edges weakened-stems shriveled-seeds)))

; conclusion: which nutrient is missing
(deftemplate deficiency
   (slot nutrient (allowed-values nitrogen phosphorus potassium)))

; input data from the task
(deffacts plant-data
   (plant (color purplish))
   (symptom (type stunted-root-growth)))

; ---------- nitrogen ----------
(defrule nitrogen-stunted-growth
   (symptom (type stunted-growth))
   =>
   (assert (deficiency (nutrient nitrogen))))

(defrule nitrogen-pale-yellow
   (plant (color pale-yellow))
   =>
   (assert (deficiency (nutrient nitrogen))))

(defrule nitrogen-reddish-brown-edges
   (symptom (type reddish-brown-leaf-edges))
   =>
   (assert (deficiency (nutrient nitrogen))))

; ---------- phosphorus ----------
(defrule phosphorus-stunted-roots
   (symptom (type stunted-root-growth))
   =>
   (assert (deficiency (nutrient phosphorus))))

(defrule phosphorus-spindly-stalk
   (symptom (type spindly-stalk))
   =>
   (assert (deficiency (nutrient phosphorus))))

(defrule phosphorus-purplish
   (plant (color purplish))
   =>
   (assert (deficiency (nutrient phosphorus))))

(defrule phosphorus-delayed-maturing
   (symptom (type delayed-maturing))
   =>
   (assert (deficiency (nutrient phosphorus))))

; ---------- potassium ----------
(defrule potassium-scorched-edges
   (symptom (type scorched-leaf-edges))
   =>
   (assert (deficiency (nutrient potassium))))

(defrule potassium-weakened-stems
   (symptom (type weakened-stems))
   =>
   (assert (deficiency (nutrient potassium))))

(defrule potassium-shriveled-seeds
   (symptom (type shriveled-seeds))
   =>
   (assert (deficiency (nutrient potassium))))

; ---------- output ----------
; CLIPS does not add the same fact twice, so each deficiency
; exists only once and the message is printed only once
(defrule print-deficiency
   (declare (salience -10))
   (deficiency (nutrient ?x))
   =>
   (printout t "The plant may have a " ?x " deficiency." crlf))

(defrule plant-is-healthy
   (declare (salience -10))
   (plant (color green))
   (not (symptom))
   =>
   (printout t "The plant is green and has no symptoms, nutrition is balanced." crlf))
