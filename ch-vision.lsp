;;;Pour Autocad Map 3D 2019;;;

;;; l'encodage semble poser problème sur cette version d'autocad, les accents ne sortent pas correctement;;;

(DEFUN C:ch-vision(/ SS-SYM EN OLD-EC NEW-EC BLC ins SCF ACT NAMEBLC  SSBLC ins1 SCFACT1 NAMEBLC1 SSBLC1)
;;Stockage des préférence 
  (setq PST (getvar "PICKSTYLE"))
  (setvar "PICKSTYLE" 0)
  (setvar "cmdecho" 0)
  (command "._ucs" "_w")
  (setq osm (getvar "osmode"))
  (setvar "osmode" 0)
  (setq lst "E-TXT-DESCRIPTIF E-REP-CHEMINEMENT E-REP-IMPLANTATION E-REP-ARPENTAGE E-VEG-ARBRE E-VEG-PLANTATION E-BAT-ACCESSOIRE E-DRA-EGOUT-PLUVIAL E-DRA-EGOUT-PLUVIAL-ELEMENT E-DRA-EAU-JOUR E-VOI-PROTECTION E-SER-AQUEDUC E-SER-AQUEDUC-ELEMENT E-SER-EGOUT-SANITAIR-ELEMENT E-SER-TEL E-SER-ELEC E-SER-ELEC-TEL E-SER-ELEC-TEL-HAUBAN E-SER-ELEC-TEL-HAUBAN E-SER-ELEC-TEL-LAMP E-SER-ELEC-LAMPAD E-SIG-ECLAIRAGE ")

;;Récupération de l'echelle
	(setq ec2 (atof(substr (getvar "cannoscale") 3)))
	(setq ec (/ ec2 1000))
		
;;Transformation des blocs	
		(progn
       (setq SS-SYM (ssget "X" '((0 . "INSERT")(410 . "Model"))))
       (if (not(null SS-SYM))
       	(progn
       		(setq compt 0)
       		(setq EN (ssname SS-SYM COMPT))
       		(while EN
       			(if (/= (vl-string-search (cdr(assoc 8 (entget EN))) lst) nil)
       				(progn
       					(setq el-lst (entget en))
       					(setq modif1  (cons 41 EC))
       					(setq modif2  (cons 42 EC))
       					(setq modif3  (cons 43 EC))

       					(setq el-lst
       						(subst modif1  (assoc 41 el-lst) el-lst))
       					(entmod el-lst)
       					(entupd en)

       					(setq el-lst
       						(subst modif2  (assoc 42 el-lst) el-lst))
       					(entmod el-lst)
       					(entupd en)

       					(setq el-lst
       						(subst modif3  (assoc 43 el-lst) el-lst))
       					(entmod el-lst)
       					(entupd en)
       					)
       				)
       			(setq compt (1+ compt))
       			(setq EN (ssname SS-SYM COMPT))
       			)
       		)
       	)
	(command "_attsync" "_n" "maison")
(princ "\nBlock modifié" )      
        
;;Transformation des textes
(setq SS-txt50 (ssget "X" '((0 . "TEXT")(7 . "TXT50")(410 . "Model"))))

(if (not(null SS-TXT50))
	(progn
		(setq compt 0)
		(setq EN (ssname SS-TXT50 COMPT))
		(setq ht-txt (* 1.5 ec))
		(while EN
			(setq el-lst (entget en))
			(setq modif  (cons 40 ht-txt))
			(setq el-lst
				(subst modif  (assoc 40 el-lst) el-lst))
			(entmod el-lst)
			(entupd en)
			(setq compt (1+ COMPT))
			(setq EN (ssname SS-txt50 COMPT))
			)
		)
	) 

(print)
(princ "style txt50 - textes existant modifiés")              
	  

         
        (setq SS-txt (ssget "X" '((0 . "TEXT")(7 . "TXT")(410 . "Model"))))

	(if (not(null SS-TXT))
		(progn
		  (setq compt 0)
                  (setq EN (ssname SS-TXT COMPT))
		  (setq ht-txt (* 1.3 ec))
                  (while EN
		    
		    (setq el-lst (entget en))
		    (setq modif  (cons 40 ht-txt))
		    (setq el-lst
			   (subst modif  (assoc 40 el-lst) el-lst))
		    (entmod el-lst)
		    (entupd en)
		    (setq compt (1+ COMPT))
		    (setq EN (ssname SS-txt COMPT))
		    )
             )
         ) 

(print)
(princ "style TXT - textes existant modifiés")              


        (setq SS-tx1 (ssget "X" '((0 . "TEXT")(7 . "TX1")(410 . "Model"))))

	(if (not(null SS-TX1))
		(progn
		  (setq compt 0)
                  (setq EN (ssname SS-TX1 COMPT))
		  (setq ht-txt (* 1.6 ec))
                  (while EN
		    (setq el-lst (entget en))
		    (setq modif  (cons 40 ht-txt))
		    (setq el-lst
			   (subst modif  (assoc 40 el-lst) el-lst))
		    (entmod el-lst)
		    (entupd en)
		    (setq compt (1+ COMPT))
		    (setq EN (ssname SS-tx1 COMPT))
		    )
             )
         )

(print)
(princ "style TX1 - textes existant modifiés")                  


        (setq SS-tx2 (ssget "X" '((0 . "TEXT")(7 . "tx2")(410 . "Model"))))

	(if (not(null SS-tx2))
		(progn
		  (setq compt 0)
                  (setq EN (ssname SS-tx2 COMPT))
		  (setq ht-txt (* 2.25 ec))
                  (while EN 
		  	(setq el-lst (entget en))
		    (setq modif  (cons 40 ht-txt))
		    (setq el-lst
			   (subst modif  (assoc 40 el-lst) el-lst))
		    (entmod el-lst)
		    (entupd en)
                  	(setq compt (1+ COMPT))
                  	(setq EN (ssname SS-tx2 COMPT))
                  )
             )
         )

(print)
(princ "style TX2 - textes existant modifiés")

        (setq SS-tx3 (ssget "X" '((0 . "TEXT")(7 . "tx3")(410 . "Model"))))

	(if (not(null SS-tx3))
		(progn
		  (setq compt 0)
                  (setq EN (ssname SS-tx3 COMPT))
		  (setq ht-txt (* 3 ec))
                  (while EN 
		  	(setq el-lst (entget en))
		    (setq modif  (cons 40 ht-txt))
		    (setq el-lst
			   (subst modif  (assoc 40 el-lst) el-lst))
		    (entmod el-lst)
		    (entupd en)
                  	(setq compt (1+ COMPT))
                  	(setq EN (ssname SS-tx3 COMPT))
                  )
             )
         )

(print)
(princ "style TX3 - textes existant modifiés")              
	  


        (setq SS-lot(ssget "X" '((0 . "TEXT")(7 . "lot")(410 . "Model"))))

	(if (not(null SS-lot))
		(progn
		  (setq compt 0)
                  (setq EN (ssname SS-lot COMPT))
		  (setq ht-txt (* 2.8222 ec))
                  (while EN 
		  	(setq el-lst (entget en))
		    (setq modif  (cons 40 ht-txt))
		    (setq el-lst
			   (subst modif  (assoc 40 el-lst) el-lst))
		    (entmod el-lst)
		    (entupd en)
                  	(setq compt (1+ COMPT))
                  	(setq EN (ssname SS-lot COMPT))
                  )
             )
         )

(print)
(princ "style LOT - textes existant modifiés")              

)
(print)
(princ "Routine complétée - version CH-VISION Aout 2021")
;;Retour des préférences
   (setvar "osmode" osm)
   (setvar "PICKSTYLE" PST)
   (command "._ucs" "_p")
(PRINC)
)
;-------------------Utilisation-------------------;
;  Change l'echelle de tout les textes et de tout ;
;    les blocs du dessin sur les calques utile    ;
;Choisir l'echelle d'annotation de la vue courante;
;    dans l'espace objet et lancer la commande.   ;
;		       Enjoy			  ;
;-------------------------------------------------;