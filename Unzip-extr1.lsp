;;;Programme revu pour Autocad francais-Février - 2015;;;

(defun c:Unzip-extr1(/ file-list file1 file2 )
  
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

