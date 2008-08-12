(require 'org)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "|" "DONE")))
(setq org-agenda-custom-commands
      '(("w" todo "WAITING" nil)
	("b" tags-todo "+bg")))
(setq org-agenda-include-diary t)

(defun ash-org-date-to-list (date)
  "Rewrite of date-to-time without the buggy
timezone-make-date-arpa-standard function"
  (condition-case ()
      (apply 'encode-time
	     (subseq (substitute 0 nil (parse-time-string date))
		     0 -3))
    (error (error "Invalid date: %s" date))))

(defun ash-org-todo-item-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "\\*+[ \t]+TODO\\>")))

(defun ash-org-mark-done ()
  (interactive)
  (save-excursion
    ;; org-entry-is-done-p has a bug where if you are at the first
    ;; char of a line it doesn't always work.  Let's work around it
    ;; here.
    (end-of-line)
    (when (not (org-entry-is-done-p))
      (org-todo 'done)
      (outline-forward-same-level 1)
      (when (ash-org-todo-item-p)
	(org-todo "NEXT")))))

(defun ash-org-advance-next ()
  "Function to run in `org-after-todo-state-change-hook'"
  (save-excursion
    (when (equal state "DONE")
      (let ((sched-date (org-entry-get (point) "SCHEDULED")))
	(outline-get-next-sibling) 
	(when (ash-org-todo-item-p)
	  (org-todo "NEXT")
	  (when sched-date
	    (org-add-planning-info
	     'scheduled
	     (ash-org-date-to-list
	      (format-time-string (car org-time-stamp-formats))))))))))

(add-hook 'org-after-todo-state-change-hook 'ash-org-advance-next)
      
(define-key global-map [f9] 'org-clock-goto)

(define-key global-map "\C-c\C-xC" 'ash-org-mark-done)

(setq org-drawers (append org-drawers '("NOTES")))

(setq org-link-frame-setup '((gnus . gnus)
			     (file . find-file-other-window)))

(require 'remember)
(require 'org-remember)
(org-remember-insinuate)

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(setq org-remember-templates
      '(("Todo" ?t "* TODO %?\nSCHEDULED: %t\n%a" "~/org/inbox.org")
	("Act on email" ?a "* TODO Reply to '%:subject' (%:group)  %a\nSCHEDULED: %t\n%!" "~/org/inbox.org")))

(define-key global-map "\C-cr" 'org-remember)

(setq org-agenda-skip-deadline-if-done 't)
(setq org-agenda-skip-scheduled-if-done 't)

(setq org-confirm-elisp-link-function nil)

(global-set-key [M-f11] 'org-agenda-goto-today)
(global-set-key [print] 'org-agenda-goto-today)

(setq org-deadline-warning-days 1)

(provide 'ash-org)
