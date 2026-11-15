; Lab 4: expert system from Lab 3 (variant 1) with functions
; input:  facts plant (color) and symptom (type)
; output: list of nutrients the plant is missing + advice

(deftemplate plant
   (slot color (allowed-values green pale-yellow purplish) (default green)))

(deftemplate symptom
   (slot type (allowed-values stunted-growth reddish-brown-leaf-edges
                              stunted-root-growth spindly-stalk delayed-maturing
                              scorched-leaf-edges weakened-stems shriveled-seeds)))

(deftemplate deficiency
   (slot nutrient (allowed-values nitrogen phosphorus potassium)))

(deffacts plant-data
   (plant (color purplish))
   (symptom (type stunted-root-growth)))

; ---------- functions ----------

; returns the nutrient for one symptom or color, or none
(deffunction nutrient-of (?s)
   (switch ?s
      (case stunted-growth then nitrogen)
      (case pale-yellow then nitrogen)
      (case reddish-brown-leaf-edges then nitrogen)
      (case stunted-root-growth then phosphorus)
      (case spindly-stalk then phosphorus)
      (case purplish then phosphorus)
      (case delayed-maturing then phosphorus)
      (case scorched-leaf-edges then potassium)
      (case weakened-stems then potassium)
      (case shriveled-seeds then potassium)
      (default none)))

; advice for a nutrient
(deffunction advice (?n)
   (switch ?n
      (case nitrogen then "use nitrogen fertilizer, for example urea")
      (case phosphorus then "use phosphorus fertilizer, for example superphosphate")
      (case potassium then "use potassium fertilizer, for example potassium sulfate")
      (default "no advice")))

; how many signs in the fact list point to this nutrient
(deffunction count-signs (?n)
   (bind ?k 0)
   (do-for-all-facts ((?f symptom)) (eq (nutrient-of ?f:type) ?n)
      (bind ?k (+ ?k 1)))
   (do-for-all-facts ((?p plant)) (eq (nutrient-of ?p:color) ?n)
      (bind ?k (+ ?k 1)))
   ?k)

; function with a group parameter: takes any number of symptoms
; and returns the list of nutrients without repeats
(deffunction diagnose ($?signs)
   (bind ?result (create$))
   (loop-for-count (?i 1 (length$ ?signs))
      (bind ?n (nutrient-of (nth$ ?i ?signs)))
      (if (and (neq ?n none) (not (member$ ?n ?result)))
         then (bind ?result (create$ ?result ?n))))
   ?result)

; ---------- rules ----------

(defrule detect-by-symptom
   (symptom (type ?s))
   =>
   (assert (deficiency (nutrient (nutrient-of ?s)))))

(defrule detect-by-color
   (plant (color ?c&~green))
   =>
   (assert (deficiency (nutrient (nutrient-of ?c)))))

; same facts are not added twice, so every nutrient is printed once
(defrule print-deficiency
   (declare (salience -10))
   (deficiency (nutrient ?n))
   =>
   (printout t "The plant may have a " ?n " deficiency (signs: "
               (count-signs ?n) "). Advice: " (advice ?n) "." crlf))

(defrule plant-is-healthy
   (declare (salience -10))
   (plant (color green))
   (not (symptom))
   =>
   (printout t "The plant is green and has no symptoms, nutrition is balanced." crlf))
