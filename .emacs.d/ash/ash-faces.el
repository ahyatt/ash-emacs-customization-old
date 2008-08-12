;; Term colors coordinated with the faces below.
(setq
 term-default-bg-color "grey12"
 term-default-fg-color "green")

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "gray12" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :family "apple-inconsolata"))))
 '(erc-input-face ((t (:foreground "yellow"))))
 '(font-lock-comment-face ((t (:foreground "chocolate1" :height 1.0 :family "apple-inconsolata"))))
 '(jabber-roster-user-online ((t (:foreground "lightgreen" :slant normal :weight bold))))
 '(message-header-subject ((t (:foreground "yellow" :weight bold))))
 '(message-header-to ((t (:foreground "SkyBlue" :weight bold))))
 '(mode-line ((t (:background "grey" :foreground "black" :box (:line-width 2 :color "grey" :style released-button) :height 80 :family "unknown-Inconsolata"))))
 '(org-agenda-date ((t (:foreground "LightBlue"))) t)
 '(org-agenda-date-weekend ((t (:foreground "Purple" :weight bold))) t)
 '(org-column ((t (:background "grey30"))))
 '(org-done ((t (:foreground "ForestGreen" :box (:line-width 2 :color "grey75" :style released-button) :weight bold))))
 '(org-todo ((t (:background "grey25" :foreground "Orange" :box (:line-width 2 :color "grey75" :style released-button) :weight bold)))))

(provide 'ash-faces)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 144 t)
 '(aquamacs-default-styles nil)
 '(aquamacs-save-options-on-quit t)
 '(custom-file nil)
 '(display-time-mode t)
 '(exec-path (quote ("/usr/local/git/bin" "/usr/local/git/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/bin" "/usr/X11/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/git/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/bin" "/usr/X11/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Aquamacs Emacs.app/Contents/MacOS/libexec" "/Applications/Aquamacs Emacs.app/Contents/MacOS/bin" "/usr/local/teTeX/bin/powerpc-apple-darwin-current" "/usr/local/share/imagemagick/bin")))
 '(icicle-apropos-cycle-next-keys (quote ((kbd ""))))
 '(icicle-generic-S-tab-keys (quote ((kbd "TAB"))))
 '(icicle-prefix-complete-keys (quote ([backtab])))
 '(icicle-reminder-prompt-flag 0)
 '(icicle-top-level-key-bindings (\` (((\, (kbd "<pause>")) icicle-switch-to/from-minibuffer t) ((\, (kbd "C-c `")) icicle-search-generic t) ((\, (kbd "C-c $")) icicle-search-word t) ((\, (kbd "C-c ^")) icicle-search-keywords t) ((\, (kbd "C-c '")) icicle-occur t) ((\, (kbd "C-c =")) icicle-imenu t) ((\, (kbd "C-c \"")) icicle-search-text-property t) ((\, (kbd "C-c /")) icicle-complete-thesaurus-entry t) ((\, (kbd "C-x M-e")) icicle-execute-named-keyboard-macro t) ((\, (kbd "C-x SPC")) icicle-command-abbrev t) ((\, (kbd "C-x 5 o")) icicle-select-frame t) ((\, (kbd "C-h C-o")) icicle-describe-option-of-type t) (abort-recursive-edit icicle-abort-recursive-edit t) (minibuffer-keyboard-quit icicle-abort-recursive-edit t) (execute-extended-command icicle-execute-extended-command t) (switch-to-buffer icicle-buffer t) (switch-to-buffer-other-window icicle-buffer-other-window t) (find-file icicle-find-file t) (find-file-other-window icicle-find-file-other-window t) (pop-tag-mark icicle-pop-tag-mark (fboundp (quote command-remapping))) (find-tag icicle-find-tag (fboundp (quote command-remapping))) (eval-expression icicle-pp-eval-expression (fboundp (quote command-remapping))) (pp-eval-expression icicle-pp-eval-expression (fboundp (quote command-remapping))) (find-tag-other-window icicle-find-first-tag-other-window t) (kill-buffer icicle-kill-buffer t) (kill-buffer-and-its-windows icicle-kill-buffer t) (delete-window icicle-delete-window t) (delete-windows-for icicle-delete-window t) (other-window-or-frame icicle-other-window-or-frame t) (other-window icicle-other-window-or-frame t) (exchange-point-and-mark icicle-exchange-point-and-mark t) (where-is icicle-where-is t) ((\, icicle-yank-function) icicle-yank-insert t) ((\, (kbd "ESC M-x")) alacarte-execute-menu-command (fboundp (quote alacarte-execute-menu-command))) ((\, (kbd "M-`")) alacarte-execute-menu-command (fboundp (quote alacarte-execute-menu-command))) ((\, (kbd "<f10>")) alacarte-execute-menu-command (fboundp (quote alacarte-execute-menu-command))))))
 '(toolbar-menu-show nil)
 '(toolbar-menu-show--help nil)
 '(transient-mark-mode t))
