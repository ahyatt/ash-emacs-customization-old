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
	("n" tags-todo "+someday"
         ((org-show-hierarchy-above nil) (org-agenda-todo-ignore-with-date t)
          (org-agenda-tags-todo-honor-ignore-options t)))
        ("l" "Agenda and live tasks" ((agenda "")
                                      (tags-todo "-someday")))
        ("f" "Focus" ((agenda "") (tags-todo "+focus")))))

(setq org-agenda-include-diary t)
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-refile-use-outline-path nil)
(setq org-refile-targets '((nil . (:maxlevel . 3))))
(setq org-use-speed-commands t)

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
      '(("Note" ?n "* %a%?\n%u\n%i" "~/org/work.org" "Unfiled notes")
        ("Journal" ?j "* %T %?" "~/org/notes.org" date-tree)
        ("Child todo" ?c "* TODO %?\n%a" "~/org/work.org" "Inbox")
        ("Todo" ?t "* TODO %?\n%a" "~/org/work.org" "Inbox")
	("Act on email" ?a "* TODO Process [%a]\n%!" "~/org/work.org" "Inbox"
         (mime-view-mode wl-summary-mode gnus-summary-mode gnus-article-mode))))

(define-key global-map "\C-cr" 'org-remember)

(setq org-agenda-skip-deadline-if-done 't)
(setq org-agenda-skip-scheduled-if-done 't)

(setq org-confirm-elisp-link-function nil)

(global-set-key [M-f11] 'org-agenda-goto-today)
(global-set-key [print] 'org-agenda-goto-today)

(setq org-deadline-warning-days 1)
(setq org-agenda-start-with-log-mode nil)

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
