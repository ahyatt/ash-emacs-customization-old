(setq load-path (append '("~/.emacs.d/ash"
                          "~/.emacs.d/misc"
                          "~/.emacs.d/bbdb"
                          "~/.emacs.d/elib"
                          "~/.emacs.d/remember"
                          "~/.emacs.d/org-mode/lisp"
                          "~/.emacs.d/org-mode/contrib/lisp"
                          "~/.emacs.d/cedet/common"
                          "~/.emacs.d/cedet/semantic"
                          "~/.emacs.d/egg"
                          "~/.emacs.d/emacs-jabber"
                          "~/.emacs.d/w3m"
        		  "~/.emacs.d/icicles"
			  "~/.emacs.d/git") load-path))

(require 'epa-file)
(epa-file-enable)

(require 'android-mode)
(setq android-mode-sdk-dir "~/android-sdk-mac_x86-1.5_r1")

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
(require 'anything)
(require 'egg)
(require 'jabber)

(push '(font-backend xft x) default-frame-alist)

(setq Info-default-directory-list 
      (cons "~/src/ash-elisp/info" Info-default-directory-list))
(color-theme-vivid-chalk)

(key-chord-define-global "aa" 'anything)
(key-chord-define-global "s;" 'anything-select-action)
(key-chord-define-global "j;" (lambda () (interactive) (switch-to-buffer "*-jabber-*")))

(setq browse-url-browser-function
      '(("google.com" . w3m-browse-url)
        ("." . browse-url-firefox)))

(require 'midnight)
(setq midnight-mode t)
(jabber-autoaway-start)

(add-hook 'eshell-mode-hook
          '(lambda ()
             (setenv
              "PATH"
              (concat "/Users/andy/android-sdk-mac_x86-1.5_r1/tools:"
                      (getenv "PATH")))))

(setq-default show-trailing-whitespace t)

(server-start)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(display-time-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(jabber-alert-message-hooks (quote (jabber-message-echo jabber-message-scroll)))
 '(jabber-alert-muc-hooks (quote (jabber-muc-scroll)))
 '(jabber-alert-presence-hooks (quote (jabber-presence-update-roster)))
 '(jabber-mode-line-mode t)
 '(show-paren-mode t)
 '(vc-follow-symlinks t))

(put 'erase-buffer 'disabled nil)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(anything-isearch-match ((t (:background "Yellow" :foreground "black"))))
 '(extra-java-font-lock-link-face ((t (:foreground "green" :underline t :slant normal))))
 '(font-lock-comment-face ((t (:foreground "#bb55ee" :slant italic))))
 '(font-lock-doc-face ((t (:foreground "LightSalmon" :height 0.8 :family "Bitstream Vera Serif"))))
 '(font-lock-function-name-face ((t (:foreground "#ffcc00" :weight bold))))
 '(git-header-face ((((class color) (background dark)) (:foreground "light blue"))))
 '(jabber-chat-prompt-local ((t (:foreground "light blue" :weight bold))))
 '(jabber-roster-user-online ((t (:foreground "light blue" :slant normal :weight bold)))))

(put 'narrow-to-region 'disabled nil)
