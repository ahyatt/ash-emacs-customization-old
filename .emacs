(setq load-path (append '("~/.emacs.d/ash"
                          "~/.emacs.d/misc"
                          "~/.emacs.d/bbdb"
                          "~/.emacs.d/elib"
                          "~/.emacs.d/remember"
                          "~/.emacs.d/org-mode/lisp"
                          "~/.emacs.d/org-mode/contrib/lisp"
                          "~/.emacs.d/cedet/common"
                          "~/.emacs.d/cedet/semantic"
                          "~/.emacs.d/w3m"
        		  "~/.emacs.d/icicles"
			  "~/.emacs.d/git") load-path))

;; workaround for emacs 23 bug
(or (functionp 'if)
    (defadvice functionp (around workaround-bug (object) activate)
      "Workaround bug."
      (or ad-do-it
            (setq ad-return-value (and (symbolp object) (fboundp object))))))

(require 'ash-customizations)
(require 'ash-refill-mode)
(require 'ash-org)
(require 'ash-eshell)
(require 'ash-java)
(require 'ash-erc)
(require 'w3m-load)
(require 'ash-faces)
(require 'git)
(require 'ash-google)
(require 'ash-cbg)
(require 'egg)
(require 'jabber)

(defun google3-build-mode-force-in-python ()
"Many BUILD files in google3 use the -*- mode: python -*- comment.
This has higher priority than auto-mode-alist, so it is necessary
to change the mode inside the mode-hook, which is done by this function"
  (when (not google3-build-mode-run-force-once)
    (let ((google3-build-mode-run-force-once t))
      (when (equal "BUILD" (file-name-nondirectory (or buffer-file-name "")))
        (google3-build-mode)))))

(setq user-mail-address "ahyatt@google.com")
(push '(font-backend xft x) default-frame-alist)

(setq p4-verbose nil)
(setq p4-do-find-file nil)
(setq py-python-command "python2.4")
(setq ssl-program-name "/home/ahyatt/bin/essl")

(setq erc-keywords '("ahyatt"))
;(setq org-ditaa-jar-path "~/bin/")

(setq Info-default-directory-list 
      (cons "~/src/ash-elisp/info" Info-default-directory-list))
(color-theme-vivid-chalk)

(key-chord-define-global "l;" '(lambda () (interactive)
                                 (magit-status default-directory)))
(key-chord-define-global "gp" 'google-compile)
(key-chord-define-global "3p" 'google3-build)
(key-chord-define-global "aa" 'anything)
(key-chord-define-global "s;" 'anything-select-action)
(key-chord-define-global "j;" (lambda () (interactive) (switch-to-buffer "*-jabber-*")))

(setq browse-url-browser-function
      '(("google.com" . w3m-browse-url)
        ("." . browse-url-firefox)))

(require 'midnight)
(jabber-autoaway-start)

(server-start)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(canlock-password "6d2d3150f801755e69cfad999ca4063943e466f4")
 '(display-time-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(erc-notify-list (quote ("agertzen" "brown")))
 '(erc-track-shorten-cutoff 8)
 '(erc-track-shorten-start 3)
 '(jabber-account-list (quote (("ahyatt@google.com" (:network-server . "talk.google.com") (:connection-type . starttls)))))
 '(jabber-alert-message-hooks (quote (jabber-message-echo jabber-message-scroll)))
 '(jabber-alert-muc-hooks (quote (jabber-muc-scroll)))
 '(jabber-alert-presence-hooks (quote (jabber-presence-update-roster)))
 '(jabber-mode-line-mode t)
 '(org-agenda-files (quote ("~/org/data/vl/j0umb1nge0@ahyatt.nyc.corp.google.com/alert-design.org" "~/org/home.org" "~/org/api.org" "~/org/gumbo.org" "~/org/ms.org" "~/org/misc-cbg.org" "~/org/inbox.org" "~/org/bugs.org" "~/org/google-misc.org" "~/org/multiple-logins.org" "~/org/misc.org")))
 '(show-paren-mode t)
 '(vc-follow-symlinks t))

(put 'erase-buffer 'disabled nil)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 116 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(put 'narrow-to-region 'disabled nil)
