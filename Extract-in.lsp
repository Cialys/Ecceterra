;;;Modifié pour Autocad francais-février 2015;;;

;;;Ce programme necessite l'exécution du programme "unzip-extr1.lsp" en premier lieux;;;
;;;Le repertoire "HH:\Sherbrooke\Compilations\Extraction\EXTRACTION\DONNEES" doit etre present dans les "Search Path..." des OPTIONS d'Autocad;;;

;;;Voici la ligne de commande à inscrire dans la macro de l'icone de commande;;;
;;;^C^C(if (null c:extract-in)(load"extract-in"));(if (null c:unzip-extr1)(load"unzip-extr1"));^C^Cunzip-extr1;(alert "Unzip ok!");extract-in; 




(defun Unzip-extr1(/ file-list file1 file2 )
  
;(alert "Les fichiers du repertoir M:\\Octr\\Donnees\\ vont etre rayes")
(setq FILE-LIST (vl-directory-files  "H:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\DONNEES\\"))
(foreach FILE1 FILE-LIST
  (progn
    (setq FILE2 (strcat "H:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\DONNEES\\/" FILE1))
    (vl-file-delete FILE2))
 );fin foreaCH
  
(if (not (vl-string-search "Drawing" (getvar "dwgname")))
  (setq FILE3 (strcat "H:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\" (VL-FILENAME-BASE (GETVAR "DWGNAME")) ".ZIP")))
  
(if (not file3)
  (setq FILE3 (getfiled "EXTRACTIONS" "H:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\"  "zip" 0))
  (setq FILE3 (getfiled "EXTRACTIONS" file3 "zip" 0))
  )

(SETQ FILE3 (vl-string-subst "~1" "m Files" file3))
;(Setq cmd-line (strcat "d:\\octr\\prog\\vb\\pkunzip.exe " FILE3 " \\WS2016-ECCSH\\M:\\EXTRAC~1\\DONNEES\\"))
(Setq cmd-line (strcat "C:\\Progra~1\\7-Zip\\7z.exe e " file3 " -oH:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\DONNEES\\"))

;(command "SH" file3)
  (command "._SH" cmd-line)

  )


(defun c:Extract-IN(/ GO FILE1 FILE2 FILE4 FILE5 FILE6 FILE7 file8 file9 FILE-LIST FILE-LIST1 DATA NBRE1 NBRE2 RAP)

(setq COUT-UNITAIRE 0.212) ;0 à 999 lots
(setq COUT-UNITAIRE1 0.03) ;1000 lots et plus  
(setq COUT-BASE     7.05)

(setvar "INSUNITS" 0)

(print " 1")
;(Unzip-extr1)

;(alert "Les fichiers du repertoir WS2016-ECCSH\\M:\\EXTRACTION\\DONNEES\\ vont etre rayes")
;(setq FILE-LIST (vl-directory-files  "WS2016-ECCSH/M:/EXTRACTION/Donnees"))
;(foreach FILE1 FILE-LIST
;  (progn
;    (setq FILE2 (strcat "WS2016-ECCSH\\M:\\EXTRACTION\\DONNEES\\" FILE1))
;    (vl-file-delete FILE2))
; );fin foreaCH

;(if (not (vl-string-search "Drawing" (getvar "dwgname")))
;  (setq FILE3 (strcat "WS2016-ECCSH\\M:\\EXTRACTION\\" (VL-FILENAME-BASE (GETVAR "DWGNAME")) ".ZIP")))
  
;(if (not file3)
;  (setq FILE3 (getfiled "EXTRACTIONS" "WS2016-ECCSH\\M:\\EXTRACTION\\"  "zip" 8)))
  ;(setq FILE3 (getfiled "EXTRACTIONS" file3 "zip" 8)))

  
;(SETQ FILE3 (vl-string-subst "~1" "TION" file3))
;(Setq cmd-line (strcat "d:\\octr\\prog\\vb\\pkunzip.exe " FILE3 "WS2016-ECCSH\\M:\\EXTRACTION\\DONNEES\\"))
		       
;(command "SH" file3)
;(command "SH" cmd-line)
  
;(SETQ go(getpoint "\nPoursuivre? Pic/Esc: "))

;(if (not (null GO))
;(progn

(SETVAR "CMDECHO" 0)

(setq FILE-LIST1 (vl-directory-files  "H:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\DONNEES\\" nil 1))
(print File-LIST1)


(foreach FILE4 FILE-LIST1
     (if (or (= "O" (substr (vl-filename-extension FILE4) 2 1))
	    (= "C" (substr (vl-filename-extension FILE4) 2 1))
	    (= "o" (substr (vl-filename-extension FILE4) 2 1))
	    (= "c" (substr (vl-filename-extension FILE4) 2 1)))
       (progn
	 (setq FILE5 (findfile FILE4))
	 (setq FILE6 (strcat "H:\\Sherbrooke\\Compilations\\Extraction\\EXTRACTION\\DONNEES\\"
			     (substr (vl-filename-extension FILE4) 2 2)
			     ".dxf"))
	 (print FILE4)
	 (print FILE5)
	 (print FILE6)

	 (if (not (vl-file-copy FILE5 FILE6))
	 	(alert (strcat "copie  " file5 "   ->   " file6 "     non completee")))

	 (print " 5")

	 ;(setq REN-FILE5 (strcat "Rename " File5 " " (substr (vl-filename-extension FILE4)2 2) ".dxf"))
	 ;(command "SH" REN-file5)
	 ;(setq FILE6 (strcat (substr (vl-filename-extension FILE4)2  2) ".dxf"))
	 
	 (command "._insert" FILE6 "0,0,0" "1" "" "0" )
	 (command "._explode" (entlast))
	 
	 );fin progn
       );fin if

  );fin foreach

(print " 6")

  (command "._regen" )
  (command "._purge" "_a" "*" "_N")
  (command "._zoom" "_e")
(SETVAR "CMDECHO" 1)

(foreach FILE4 FILE-LIST1
(if (or (= ".rap" (vl-filename-extension FILE4))
	(= ".RAP" (vl-filename-extension FILE4)))
	(progn
          (setq FILE7 (open (findfile FILE4) "r"))
          (setq DATA (read-line FILE7))
          (while DATA
           (cond((= (substr DATA 1 40) "Le nombre de lots officiels géométriques")
                    (setq NBRE1 (atoi (substr DATA 57 5)))
                    )
                ((= (substr DATA 1 40) "Le nombre de lots de contexte extraits e")
                    (setq NBRE2 (atoi (substr DATA 46 5)))
                    )
            );fin cond        
          (setq DATA (read-line FILE7))
          );fin while
	  (CLOSE FILE7) 
      );fin progn
);fin if
);fin foreach



;mis-a jour du fihier EXTRACTION.txt donnant les lot extrait-vs- date;;;
;(foreach FILE4 FILE-LIST1
;(if (or (= ".d01" (vl-filename-extension FILE4))
;	(= ".D01" (vl-filename-extension FILE4)))
;	(progn
;          (setq FILE8 (open (findfile FILE4) "r"))
;	  (setq FILE9 (open "M:/EXTRACTION/Extraction.txt" "a"))
;          (setq DATA (read-line FILE8))
;          (while DATA
;           (if(= (substr DATA 1 2) "LO")
;	     (progn
;	       (setq Lot (substr DATA 4 9))
;	       (print)
;	       (princ lot)
;	       (setq line (strcat lot "  -  " (vl-filename-base file3) ".zip"))
;	       (write-line line file9)
;	       (setq DATA (read-line FILE8))
;	       )
;	     (setq DATA (read-line FILE8))
;	     )
;	    )
;	  )
;  
;  )
;  )
;  (close FILE9)

(princ)
(print "passe")


(cond
  ((> 999 (+ NBRE1 NBRE2))
   (setq COUT(strcat
	     "Nombre de lots extrait: "
	     (itoa (+ NBRE1 NBRE2))
	     " - "
	     (rtos  (+ COUT-BASE (* (+ NBRE1 NBRe2) COUT-UNITAIRE))2 2)
	     "$"
	     ))
   )

  ((< 999 (+ NBRE1 NBRE2))
   (setq COUT(strcat
	     "Nombre de lots extrait: "
	     (itoa (+ NBRE1 NBRE2))
	     " - "
	     (rtos  (+ COUT-BASE 199.80 (* (- (+ NBRE1 NBRE2) 999.0) COUT-UNITAIRE1))2 2)
	     "$"
	     ))
   )
  )

  
(textscr)
(print)
(princ (strcat "File: "(vl-filename-base file3)))
(print COUT)
;(setvar "USERR2" (+ COUT-BASE (* (+ NBRE1 NBRe2) COUT-UNITAIRE)))  
(princ)
;);fin progn
;(exit)
;  );fin if
)