(require 'ash-helper-functions)

(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

(global-set-key [(control c)(control z)(control s)] 'jde-bug-start-debugger )
(global-set-key [(control c)(control z)(control e)] 'jde-bug-exit )
(global-set-key [(control c)(control z)(control l)] 'jde-bug-launch-process )
(global-set-key [(control c)(control z)(control f)] 'jde-bug-finish-process )
(global-set-key [(control c)(control z)(control d)] 'jde-bug-detach-process)
(global-set-key [(control c)(control v)(control z)] 'jde-import-find-and-import )
;(global-set-key [f9] 'jde-bug-toggle-breakpoint )
;(global-set-key [f10] 'jde-bug-step-over )
;(global-set-key [f11] 'jde-bug-step-into )
;(global-set-key [f12] 'jde-bug-step-out )

(setq flymake-allowed-file-name-masks
      '(("\\.java$" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)))

(setq auto-mode-alist
      (assoc-replace auto-mode-alist	
		     '(("\\.java\\'" .    jde-mode))))

(defadvice yank (after jde-indent-after-yank activate)
  "Do an indent after a yank"
  (if (eq major-mode 'jde-mode)
	  (let ((transient-mark-mode nil))
        (indent-region (region-beginning) (region-end) nil))))

(require 'cedet)
(require 'jde)
(require 'jde-eclipse-compiler-server)

(provide 'ash-jde)