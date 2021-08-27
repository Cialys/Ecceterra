(defun c:id-maison()
  (SETVAR "ATTDIA" 0)
  (setq ec (/ (atof(substr (getvar "cannoscale") 3)) 1000))
  (command-s "._layer" "_s" "E-TXT-DESCRIPTIF" "")
  (setq m1 " ")
  (setq m2 (getstring t "\nType de batiment: [Maison unifamiliale/Immeuble d'habitation multifamiliale/BAtiment commercial/BATiment industriel/MAison unifamiliale Jumelée/MAIson unifamiliale en Rangée/Remise/Garage]"))
  ;Vérifie si il y as un éspace dans m2
  (setq sppos (vl-string-search " " m2))
  ;Si oui, place la première partie dans m1
  (if (/= nil sppos)
    (progn
      (setq m1(substr m2 1 sppos))
      (setq m2(substr m2 (+ 2 sppos)))
    )
  )
  ;Vérifie si une option a été cliqué, si oui place la réponse associée dans m1 et m2
      (cond
      ((= m2 "M")(progn (setq m2 "unifamiliale")(setq m1 "Maison")))
      ((= m2 "I")(progn (setq m2 "multifamiliale")(setq m1 "Immeuble d'habitation")))
      ((= m2 "BA")(progn (setq m2 "commercial")(setq m1 "Batiment")))
      ((= m2 "BAT")(progn (setq m2 "industriel")(setq m1 "Batiment")))
      ((= m2 "MA")(progn (setq m2 "jumelée")(setq m1 "Maison unifamiliale")))
      ((= m2 "MAI")(progn (setq m2 "en rangée")(setq m1 "Maison unifamiliale")))
      ((= m2 "R")(progn (setq m2 "Remise")(setq m1 " ")))
      ((= m2 "G")(progn (setq m2 "Garage")(setq m1 " ")))
    )
  ;Récupération du nombre d'étage
  (menucmd "S=etage")
  (setq eta (getstring t "\nNombre d'étages: [1/2/3/4/5]"))
  (if (= eta "1")
    (setq eta (strcat eta " étage"))
    (setq eta (strcat eta " étages")))
  ;Récupération du revêtement et du numéro civic
  (menucmd "S=comm")
  (setq rev (getstring t "\nRevêtement: "))
  (setq civ (getstring t "\nNo civ: "))
  (if (/= civ "")
    (setq civ (strcat "# " civ)))
  ;Insertion
  (setq pt (getpoint "\nInsertion"))
  (command-s "._insert" "maison" pt ec "" "" m1 m2 eta civ rev)
)


;-------------------Utilisation-----------------------;
;1ere étape, choisir le type de bâtiment, possible    ;
;de l'ecrire pour les cas spéciaux (deux mots maximum);
;  2eme étapes, choisir ou ecrire le nombre d'étage   ;
;     (s'accorde automatiquement en nombre)           ;
;         3eme étape, ecrire le revêtement            ;
;4eme étape, ecrire le numéro civique (si vide, le #  ;
;                   n'apparait pas)                   ;
;     5eme étape, cliquer à la position voulue        ;
;6eme étape, entrer une note supplémentaire ou valider;
;                    avec Entrer                      ;
;                       Enjoy                         ;
;-----------------------------------------------------;