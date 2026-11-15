; Lab 5, individual task (variant 1): family tree

; ---------- given templates ----------
(deftemplate father-of  (slot father)  (slot child))
(deftemplate mother-of  (slot mother)  (slot child))
(deftemplate male       (slot person))
(deftemplate female     (slot person))
(deftemplate wife-of    (slot wife)    (slot husband))
(deftemplate husband-of (slot husband) (slot wife))

; ---------- my templates for the result ----------
(deftemplate parent-of      (slot parent)      (slot child))
(deftemplate sibling-of     (slot person)      (slot sibling))
(deftemplate brother-of     (slot brother)     (slot person))
(deftemplate sister-of      (slot sister)      (slot person))
(deftemplate uncle-of       (slot uncle)       (slot person))
(deftemplate aunt-of        (slot aunt)        (slot person))
(deftemplate cousin-of      (slot cousin)      (slot person))
(deftemplate grandparent-of (slot grandparent) (slot person))
(deftemplate grandfather-of (slot grandfather) (slot person))
(deftemplate grandmother-of (slot grandmother) (slot person))
(deftemplate ancestor-of    (slot ancestor)    (slot person))

; ---------- family for testing ----------
;  Ivan + Maria
;   |- Petro + Nina
;   |    |- Danylo + Kateryna
;   |    |    |- Sofia
;   |    |- Iryna
;   |- Olha + Taras
;   |    |- Oleh
;   |- Andriy
(deffacts family
   (male (person Ivan))    (female (person Maria))
   (male (person Petro))   (female (person Nina))
   (female (person Olha))  (male (person Taras))
   (male (person Andriy))
   (male (person Danylo))  (female (person Kateryna))
   (female (person Iryna)) (male (person Oleh))
   (female (person Sofia))
   (wife-of (wife Maria)    (husband Ivan))
   (wife-of (wife Nina)     (husband Petro))
   (wife-of (wife Olha)     (husband Taras))
   (wife-of (wife Kateryna) (husband Danylo))
   (father-of (father Ivan)   (child Petro))
   (father-of (father Ivan)   (child Olha))
   (father-of (father Ivan)   (child Andriy))
   (mother-of (mother Maria)  (child Petro))
   (mother-of (mother Maria)  (child Olha))
   (mother-of (mother Maria)  (child Andriy))
   (father-of (father Petro)  (child Danylo))
   (father-of (father Petro)  (child Iryna))
   (mother-of (mother Nina)   (child Danylo))
   (mother-of (mother Nina)   (child Iryna))
   (father-of (father Taras)  (child Oleh))
   (mother-of (mother Olha)   (child Oleh))
   (father-of (father Danylo) (child Sofia))
   (mother-of (mother Kateryna) (child Sofia)))

; ---------- helper rules ----------
(defrule husband-from-wife
   (wife-of (wife ?w) (husband ?h))
   =>
   (assert (husband-of (husband ?h) (wife ?w))))

(defrule parent-from-father
   (father-of (father ?p) (child ?c))
   =>
   (assert (parent-of (parent ?p) (child ?c))))

(defrule parent-from-mother
   (mother-of (mother ?p) (child ?c))
   =>
   (assert (parent-of (parent ?p) (child ?c))))

; two different people with a common parent
(defrule find-siblings
   (parent-of (parent ?p) (child ?a))
   (parent-of (parent ?p) (child ?b&~?a))
   =>
   (assert (sibling-of (person ?a) (sibling ?b))))

; ---------- d) brother, sister ----------
(defrule find-brother
   (sibling-of (person ?x) (sibling ?b))
   (male (person ?b))
   =>
   (assert (brother-of (brother ?b) (person ?x))))

(defrule find-sister
   (sibling-of (person ?x) (sibling ?s))
   (female (person ?s))
   =>
   (assert (sister-of (sister ?s) (person ?x))))

; ---------- a) uncle, aunt ----------
; brother of a parent
(defrule find-uncle
   (parent-of (parent ?p) (child ?x))
   (brother-of (brother ?u) (person ?p))
   =>
   (assert (uncle-of (uncle ?u) (person ?x))))

; husband of an aunt
(defrule find-uncle-by-marriage
   (aunt-of (aunt ?a) (person ?x))
   (husband-of (husband ?u) (wife ?a))
   =>
   (assert (uncle-of (uncle ?u) (person ?x))))

; sister of a parent
(defrule find-aunt
   (parent-of (parent ?p) (child ?x))
   (sister-of (sister ?a) (person ?p))
   =>
   (assert (aunt-of (aunt ?a) (person ?x))))

; wife of an uncle
(defrule find-aunt-by-marriage
   (uncle-of (uncle ?u) (person ?x))
   (wife-of (wife ?a) (husband ?u))
   =>
   (assert (aunt-of (aunt ?a) (person ?x))))

; ---------- b) cousin ----------
; children of two siblings
(defrule find-cousin
   (parent-of (parent ?p1) (child ?x))
   (sibling-of (person ?p1) (sibling ?p2))
   (parent-of (parent ?p2) (child ?c))
   =>
   (assert (cousin-of (cousin ?c) (person ?x))))

; ---------- c) grandparent ----------
(defrule find-grandparent
   (parent-of (parent ?g) (child ?p))
   (parent-of (parent ?p) (child ?x))
   =>
   (assert (grandparent-of (grandparent ?g) (person ?x))))

; ---------- g) grandfather, grandmother ----------
(defrule find-grandfather
   (grandparent-of (grandparent ?g) (person ?x))
   (male (person ?g))
   =>
   (assert (grandfather-of (grandfather ?g) (person ?x))))

(defrule find-grandmother
   (grandparent-of (grandparent ?g) (person ?x))
   (female (person ?g))
   =>
   (assert (grandmother-of (grandmother ?g) (person ?x))))

; ---------- e) ancestor ----------
; a parent is an ancestor
(defrule ancestor-parent
   (parent-of (parent ?p) (child ?x))
   =>
   (assert (ancestor-of (ancestor ?p) (person ?x))))

; a parent of an ancestor is also an ancestor
(defrule ancestor-recursive
   (ancestor-of (ancestor ?a) (person ?x))
   (parent-of (parent ?p) (child ?a))
   =>
   (assert (ancestor-of (ancestor ?p) (person ?x))))

; ---------- output after all relations are found ----------
; different salience makes the output go in groups
(defrule print-brother (declare (salience -10))
   (brother-of (brother ?b) (person ?x))
   => (printout t ?b " is a brother of " ?x crlf))

(defrule print-sister (declare (salience -11))
   (sister-of (sister ?s) (person ?x))
   => (printout t ?s " is a sister of " ?x crlf))

(defrule print-uncle (declare (salience -12))
   (uncle-of (uncle ?u) (person ?x))
   => (printout t ?u " is an uncle of " ?x crlf))

(defrule print-aunt (declare (salience -13))
   (aunt-of (aunt ?a) (person ?x))
   => (printout t ?a " is an aunt of " ?x crlf))

(defrule print-cousin (declare (salience -14))
   (cousin-of (cousin ?c) (person ?x))
   => (printout t ?c " is a cousin of " ?x crlf))

(defrule print-grandparent (declare (salience -15))
   (grandparent-of (grandparent ?g) (person ?x))
   => (printout t ?g " is a grandparent of " ?x crlf))

(defrule print-grandfather (declare (salience -16))
   (grandfather-of (grandfather ?g) (person ?x))
   => (printout t ?g " is a grandfather of " ?x crlf))

(defrule print-grandmother (declare (salience -17))
   (grandmother-of (grandmother ?g) (person ?x))
   => (printout t ?g " is a grandmother of " ?x crlf))

(defrule print-ancestor (declare (salience -18))
   (ancestor-of (ancestor ?a) (person ?x))
   => (printout t ?a " is an ancestor of " ?x crlf))
