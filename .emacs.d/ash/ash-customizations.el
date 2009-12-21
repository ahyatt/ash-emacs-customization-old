;; Save minibuffer history
(savehist-mode 1)

;; Unique buffers
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(add-to-list 'after-make-frame-functions
             (lambda (frame) (select-frame frame) (set-terminal-coding-system 'utf-8)))

(setenv "EDITOR" "emacsclient")

(global-font-lock-mode t)

(defmacro when-emacs (&rest rest)
    `(when (not (string-match "[Xx]emacs" (emacs-version)))
       ,@rest))

(defun make-buffer-big5 () (interactive)
  (set-language-environment "Chinese-BIG5"))
(global-set-key (kbd "C-c b") 'make-buffer-big5)

;; Replace yes or no questions with y or n questions (less typing)
(fset 'yes-or-no-p 'y-or-n-p)

(defun toggle-c-basic-offset ()
   "Switch between two- and four-space indentation (`c-basic-offset')
in Java, C, and C++ modes.  Don't change the amount of indentation for
styles that aren't already using two or four spaces."
   (interactive)
   (if (not (memq major-mode '(c-mode c++-mode java-mode jde-mode)))
       (error "TOGGLE-C-BASIC-OFFSET only works in C, C++, and Java modes."))
   (setq c-basic-offset (if (= c-basic-offset 2) 4 2))
   (message "C-BASIC-OFFSET is now set to %s." c-basic-offset))

(define-key global-map "\M-g" 'goto-line)

(define-key global-map "\M-/" 'hippie-expand)
;; just try-expand-line, which I dislike
(setq hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol))

;; case-insensitive search
(setq case-fold-search t)

;; show parenthesis matching
(show-paren-mode t)

;; highlight region
(setq transient-mark-mode t)

;; define my identity
(setq user-full-name "Andrew Hyatt")

;; Colors work well in shell
(add-hook 'shell-mode-hook (lambda () (ansi-color-for-comint-mode-on)))

;; enable visual feedback on selections
(setq transient-mark-mode t)

(setq blink-cursor-mode t)

(setq bookmark-save-flag 1)

;; I like ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("java" (mode . java-mode))
	       ("shell" (mode . shell-mode))
	       ("eshell" (mode . eshell-mode))
	       ("lisp" (mode . emacs-lisp-mode))
	       ("erc" (mode . erc-mode))
	       ("org" (mode . org-mode))
	       ("git" (mode . git-status-mode))
	       ("c++" (or
                       (mode . cc-mode)
                       (mode . c++-mode)))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ("gnus" (or
			(mode . message-mode)
			(mode . bbdb-mode)
			(mode . mail-mode)
			(mode . gnus-group-mode)
			(mode . gnus-summary-mode)
			(mode . gnus-article-mode)
			(name . "^\\.bbdb$")
			(name . "^\\.newsrc-dribble")))))))

(add-to-list 'auto-mode-alist '("\\.emacs" . emacs-lisp-mode))

(setq ibuffer-sorting-mode 'recency)

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

;; ffap seems to disable ido for filenames, which has it's own ffap bindings
;(require 'ffap)
;(ffap-bindings)

(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)
(global-set-key [(control f12)] 'ibuffer)
(recentf-mode)

(set-default 'indent-tabs-mode nil)

(display-time-mode 't)

(partial-completion-mode)

(define-key global-map "\C-x\C-j" 'dired-jump)

;; backup stuff from http://wiki.corp.google.com/twiki/bin/view/Main/GnuEmacsBackupFiles
;; Put autosave files (ie #foo#) in one place, *not* scattered all over the
;; file system! (The make-autosave-file-name function is invoked to determine
;; the filename of an autosave file.)
(defvar autosave-dir (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)

;; Remove unnecessary stuff that takes up space
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(ido-mode)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'dabbrev-expand)
(key-chord-define-global "l;" 'magit-status)
(key-chord-define-global "`1" 'yas/expand)
(key-chord-define-global "-=" (lambda () (interactive) (switch-to-buffer "*compilation*")))

(require 'bbdb)

(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)))

;; yas (dynamic templates)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (indent-region yas/snippet-beg
                            yas/snippet-end)))


(defadvice yank (after c-indent-after-yank activate)
  "Do an indent after a yank"
  (if c-buffer-is-cc-mode
      (let ((transient-mark-mode nil))
        (indent-region (region-beginning) (region-end) nil))))

;; Easy sudo editing, never switch to vi again!  it doesn't seem to
;; work, because it doesn't ask for a password, though.
(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer)))))
(key-chord-define-global "fg" 'sudo-edit-current-file)

;; Change the jabber mode line to not display counts

;; I don't like the jabber modeline having counts, it takes up too
;; much room.
(defadvice jabber-mode-line-count-contacts (around ash-remove-jabber-counts
                                                   (&rest ignore))
  "Override for count contacts, to remove contacts from modeline"
  (setq ad-return-value ""))
(ad-activate 'jabber-mode-line-count-contacts)

(defun ash-ibuffer-project-files ()
  "This is predicated on having a per-project `ash-project-name'
and `ash-project-root' variables."
  (interactive)
  (if (and (boundp 'ash-project-name) (boundp 'ash-project-root))
      (ibuffer nil (concat "*ibuffer for " ash-project-name "*")
               ('filename . ash-project-root))
    (error "not ash-project-name or ash-project-root variable set")))

(global-set-key [(f12)] 'ash-ibuffer-project-files)

;; from http://www.emacswiki.org/emacs/RecentFiles
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
	  (mapcar (lambda (x)
		    (cons (file-name-nondirectory x)
			  x))
		  recentf-list))
	 (filename-list
	  (remove-duplicates (mapcar #'car file-assoc-list)
			     :test #'string=))
	 (filename (ido-completing-read "Choose recent file: "
					filename-list
					nil
					t)))
    (when filename
      (find-file (cdr (assoc filename
			     file-assoc-list))))))

(key-chord-define-global "xb" 'recentf-ido-find-file)
(key-chord-define-global "xg" 'execute-extended-command)

(require 'undo-tree)

(global-undo-tree-mode)

(provide 'ash-customizations)
