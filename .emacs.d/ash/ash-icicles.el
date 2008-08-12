(require 'icicles)
(icicle-mode)


;; Mostly from http://www.emacswiki.org/cgi-bin/wiki/RubikitchIciclesConfiguration

;;; I prefer modal cycling.
(setq icicle-cycling-respects-completion-mode-flag t)
;;  I HATE arrow keys.
(setq icicle-modal-cycle-up-key "\C-p")
(setq icicle-modal-cycle-down-key "\C-n")


;;; Key bindings
(add-hook 'icicle-mode-hook 'bind-my-icicles-keys)
;; (to "describe-keymaps")
;; Refactored the code in `Icicles - Customizing Key Bindings' at EmacsWiki.
(defun bind-my-icicles-keys ()
  "Replace some default Icicles bindings with others I prefer."
  (when icicle-mode
    (dolist (map (append (list minibuffer-local-completion-map
                               minibuffer-local-must-match-map)
                         (and (boundp 'minibuffer-local-filename-completion-map)
                              (list minibuffer-local-filename-completion-map))))
      (bind-my-icicles-keys--for-completion-map map)
      (bind-my-icicles-keys--for-all-minibuffer-map map))
    (let ((map minibuffer-local-map))
      (bind-my-icicles-keys--for-all-minibuffer-map map))
    (bind-my-icicles-keys--for-icicle-mode-map icicle-mode-map)))
;; test bind-my-icicles-keys -> (bind-my-icicles-keys)

;; [2006/12/25]
;; (to "describe-keymaps")
(defun bind-my-icicles-keys--for-all-minibuffer-map (map)
  (define-key map "\C-e" 'icicle-guess-file-at-point-or-end-of-line)
  (define-key map "\C-k" 'icicle-erase-minibuffer-or-kill-line)  ; M-k or C-k
  )
;; I think default icicles key bindings are hard to type.
(defun bind-my-icicles-keys--for-completion-map (map)
;; (to "icicle-remap-example")
  ;; C-o is next to C-i.
  (define-key map "\C-o" 'icicle-apropos-complete)      ; S-Tab
  ;; Narrowing is isearch in a sense. C-s in minibuffer is rarely used.
  (define-key map "\C-s" 'icicle-narrow-candidates)     ; M-*
  ;; History search is isearch-backward chronologically:-)
  (define-key map "\C-r" 'icicle-history)               ; M-h

  (define-key map "\M-{" 'icicle-previous-prefix-candidate-action) ; C-up
  (define-key map "\M-}" 'icicle-next-prefix-candidate-action) ; C-down
  (define-key map "\C-z" 'icicle-help-on-candidate)            ; C-M-Ret

  ;; I do not use icicles' C-v M-C-v anymore.
  (define-key map "\C-v" 'scroll-other-window) ; M-C-v
  (define-key map "\M-v" 'scroll-other-window-down)
  )
(defun bind-my-icicles-keys--for-icicle-mode-map (map)
  ;; These are already bound in global-map. I'll remap them.
  (define-key map [f5] nil)             ; icicle-kmacro
  (define-key map [pause] nil)          ; 
  )

(provide 'ash-icicles)