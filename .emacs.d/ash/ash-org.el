(require 'org)
(require 'org-attach)
(require 'org-exp-blocks)
(require 'org-screen)

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
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)

(define-key global-map [f9] 'org-clock-goto)

(setq org-drawers (append org-drawers '("NOTES")))

(setq org-link-frame-setup '((gnus . gnus)
			     (file . find-file-other-window)))

(set-face-attribute 'org-mode-line-clock nil
                    :family "Lucida Sans Italic" :italic t)

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
(setq org-agenda-start-with-log-mode t)

(setq org-completion-use-ido t)
(setq org-use-fast-todo-selection t)

(defun ash-jabber-colorize-tags ()
  (let ((contact-hash (make-hash-table :test 'equal)))
    (dolist (jc jabber-connections)
      (dolist (contact (plist-get (fsm-get-state-data jc) :roster))
        (puthash (car (split-string (symbol-name contact) "@")) contact contact-hash)))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward ":\\(\\w+\\):" nil t)
        (let ((tag (match-string-no-properties 1)))
          (when (and tag (gethash tag contact-hash))
            (let* ((js (jabber-jid-symbol (gethash tag contact-hash)))
                   (connected (get js 'connected))
                   (show (get js 'show)))
              (if connected
                  (let ((o (make-overlay (match-beginning 1) (- (point) 1))))
                    (overlay-put o 'face
                                 (cons 'foreground-color
                                       (cond ((equal "away" show)
                                              "orange")
                                             ((equal "dnd" show)
                                              "red")
                                             (t "green")))))))))
        (backward-char)))))

(provide 'ash-org)
