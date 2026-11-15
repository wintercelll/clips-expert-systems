; Lab 5, general task: infix expressions in prefix form

; a) (3 + 4) * (5 + 6) + 7
(deffunction expr-a ()
   (+ (* (+ 3 4) (+ 5 6)) 7))

; b) (5 * (5 + 6 + 7)) - ((3 * (4 / 9) + 2) / 8)
(deffunction expr-b ()
   (- (* 5 (+ 5 6 7))
      (/ (+ (* 3 (/ 4 9)) 2) 8)))

; c) 6 - 9 * 8 / 3 + 4 - (8 - 2 - 3) * 6 / 7
(deffunction expr-c ()
   (- (+ (- 6 (/ (* 9 8) 3)) 4)
      (/ (* (- (- 8 2) 3) 6) 7)))
