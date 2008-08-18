(require 'esh-mode)

;; Most of this is from a useful post on eshell:
;; http://dryice.name/blog/emacs/eshell/

(setq eshell-save-history-on-exit t
      eshell-history-size 512
      eshell-hist-ignoredups t
      eshell-cmpl-cycle-completions t
      
      ;; scroll to the bottom
      eshell-scroll-to-bottom-on-output t
      eshell-scroll-show-maximum-output t)

(add-to-list 'eshell-output-filter-functions 'eshell-postoutput-scroll-to-bottom)

(add-hook 'eshell-mode-hook
          (lambda () (define-key eshell-mode-map "\C-a" 'eshell-bol)))

(global-set-key [f1] (lambda () (interactive) (switch-to-buffer "*eshell*")))
(global-set-key [f2] (lambda () (interactive) (switch-to-buffer "*eshell*<2>")))

(provide 'ash-eshell)