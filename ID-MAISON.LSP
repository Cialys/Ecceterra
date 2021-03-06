(defun c:id-maison()
  (SETVAR "ATTDIA" 0)
  (setq ec (/ (atof(substr (getvar "cannoscale") 3)) 1000))
  (command-s "._layer" "_s" "E-TXT-DESCRIPTIF" "")
  (setq m1 " ")
  (setq m2 (getstring t "\nType de batiment: [Maison unifamiliale/Immeuble d'habitation multifamiliale/BAtiment commercial/BATiment industriel/MAison unifamiliale Jumel�e/MAIson unifamiliale en Rang�e/Remise/Garage]"))
  ;V�rifie si il y as un �space dans m2
  (setq sppos (vl-string-search " " m2))
  ;Si oui, place la premi�re partie dans m1
  (if (/= nil sppos)
    (progn
      (setq m1(substr m2 1 sppos))
      (setq m2(substr m2 (+ 2 sppos)))
    )
  )
  ;V�rifie si une option a �t� cliqu�, si oui place la r�ponse associ�e dans m1 et m2
      (cond
      ((= m2 "M")(progn (setq m2 "unifamiliale")(setq m1 "Maison")))
      ((= m2 "I")(progn (setq m2 "multifamiliale")(setq m1 "Immeuble d'habitation")))
      ((= m2 "BA")(progn (setq m2 "commercial")(setq m1 "Batiment")))
      ((= m2 "BAT")(progn (setq m2 "industriel")(setq m1 "Batiment")))
      ((= m2 "MA")(progn (setq m2 "jumel�e")(setq m1 "Maison unifamiliale")))
      ((= m2 "MAI")(progn (setq m2 "en rang�e")(setq m1 "Maison unifamiliale")))
      ((= m2 "R")(progn (setq m2 "Remise")(setq m1 " ")))
      ((= m2 "G")(progn (setq m2 "Garage")(setq m1 " ")))
    )
  ;R�cup�ration du nombre d'�tage
  (menucmd "S=etage")
  (setq eta (getstring t "\nNombre d'�tages: [1/2/3/4/5]"))
  (if (= eta "1")
    (setq eta (strcat eta " �tage"))
    (setq eta (strcat eta " �tages")))
  ;R�cup�ration du rev�tement et du num�ro civic
  (menucmd "S=comm")
  (setq rev (getstring t "\nRev�tement: "))
  (setq civ (getstring t "\nNo civ: "))
  (if (/= civ "")
    (setq civ (strcat "# " civ)))
  ;Insertion
  (setq pt (getpoint "\nInsertion"))
  (command-s "._insert" "maison" pt ec "" "" m1 m2 eta civ rev)
)


;-------------------Utilisation-----------------------;
;1ere �tape, choisir le type de b�timent, possible    ;
;de l'ecrire pour les cas sp�ciaux (deux mots maximum);
;  2eme �tapes, choisir ou ecrire le nombre d'�tage   ;
;     (s'accorde automatiquement en nombre)           ;
;         3eme �tape, ecrire le rev�tement            ;
;4eme �tape, ecrire le num�ro civique (si vide, le #  ;
;                   n'apparait pas)                   ;
;     5eme �tape, cliquer � la position voulue        ;
;6eme �tape, entrer une note suppl�mentaire ou valider;
;                    avec Entrer                      ;
;                       Enjoy                         ;
;-----------------------------------------------------;