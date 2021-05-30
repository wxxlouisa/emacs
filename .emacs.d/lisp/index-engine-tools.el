;; 

(defun IE-gen-unittest()
 "generate the 'INDEXLIB_UNIT_TEST_CASE(function-name, case_ID);' at the end of the file"
 (interactive)
 (goto-char (point-min))
 (let ((i 0))
  (while (search-forward "void TestCase" nil t)
    (setq i (1+ i))
      (backward-char 8)
      (setq offset1 (point))
      (skip-chars-forward "-_A-Za-z0-9")
      (setq offset2 (point))
      (setq funcname (buffer-substring-no-properties offset1 offset2))
      (setq mystr (format "INDEXLIB_UNIT_TEST_CASE(%s, REP_%03d);\n" funcname i))
      (goto-char (point-max))
      (insert mystr)
      (goto-char offset2)
   )
  (goto-char (point-max))
  ))

; (if (< 3 2)  (message "yes")  (message "no") )
; will print no

(defun IE-is-compile-succ()
 "check if compile is successful"
 (interactive)
 (let ((case-fold-search nil))
 (let ((i 0) (offset (point-min)))
   ; find FAIL
   (goto-char (point-min))
   (while (search-forward "FAIL" nil t)
     (setq i 1)
     (setq offset (point))
     (message "found FAIL")
     (goto-char (point-max))
     )
   ; find segment
   (goto-char (point-min))
   (if (< i 1)
   (while (search-forward "Segment" nil t)
     (setq i 1)
     (setq offset (point))
     (message "found Segment")
     (goto-char (point-max))
     ))
   ; find abort
   (goto-char (point-min))
   (if (< i 1)
   (while (search-forward "Abort" nil t)
     (setq i 1)
     (setq offset (point))
     (message "found Abort")
     (goto-char (point-max))
     ))
   ; goto error line
   (if (> i 0)       
       (goto-char offset)
     (message "compile successfully")
     )
   ))
 )

(provide 'index-engine-tools)
