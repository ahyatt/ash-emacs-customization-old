(require 'ash-helper-functions)

(defvar ash-refill-mode nil
  "Mode variable for refill minor mode")
(make-variable-buffer-local 'ash-refill-mode)

(defun ash-refill-mode (&optional arg)
  "Refill minor mode"
  (interactive "P")
  (setq ash-refill-mode
	(if (null arg)
	    (not ash-refill-mode)
	  (> (prefix-numeric-value arg) 0)))
  (if ash-refill-mode
      (add-hook 'after-change-functions 'ash-refill nil t)
    (remove-hook 'after-change-functions 'ash-refill t)))
		  

(defun same-line-p (start end)
  "Are START and END on the same line?"
  (limited-save-excursion
    (goto-char start)
    (end-of-line)
    (<= end (point))))

(defun short-line-p (pos)
  "Does line containing POS stay within `fill-column'?"
  (limited-save-excursion
   (goto-char pos)
   (end-of-line)
   (<= (current-column) fill-column)))

(defun before-2nd-word-p (pos)
  "Does POS lie before the second word on the line?"
  (limited-save-excursion
   (goto-char pos)
   (beginning-of-line)
   (skip-syntax-forward (concat "^ "
			(char-to-string (char-syntax ?\n))))
   (skip-syntax-forward " ")
   (< pos (point))))

(defun in-paragraph-separator-p ()
  (limited-save-excursion
   (goto-char (line-beginning-position))
   (looking-at (concat paragraph-separate "$"))))

(defun after-paragraph-separator-p (pos)
  "Is POS actually within a paragraph separator?"
  (limited-save-excursion
   (goto-char pos)
   (beginning-of-line 0)
   (in-paragraph-separator-p)))
   
(defun ash-refill (start end len)
  "After a text change, refill the current paragraph."
  (if (not (in-paragraph-separator-p))
      (let ((left (if (or (zerop len)
			  (not (before-2nd-word-p start))
			  (after-paragraph-separator-p (start)))
		      start
		    (limited-save-excursion
		    (max (progn
			   (goto-char start)
			   (beginning-of-line 0)
			   (point))
			 (progn
			   (goto-char start)
			   (backward-paragraph 1)
			   (point)))))))
	(if (or (and (zerop len)
		     (same-line-p start end)
		     (short-line-p end))
		(and (eq (char-syntax (preceding-char))
		?\ )
		     (looking-at "\\s *$")))
	    nil
	  (limited-save-excursion
	   (fill-region left end nil nil t))))))
		 
(if (not (assq 'ash-refill-mode minor-mode-alist))
    (setq minor-mode-alist
	  (cons '(ash-refill-mode " ASH-Refill")
		minor-mode-alist)))

(provide 'ash-refill-mode)