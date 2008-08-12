(require 'term)

;; I like some dabbrev-completion in my term
(defun ash-term-hooks ()
  (define-key term-raw-escape-map "/"
    (lambda () (interactive)
      (let ((beg (point)))
	(dabbrev-expand nil)
	(kill-region beg (point)))
      (term-send-raw-string (substring-no-properties (current-kill 0))))))

(add-hook 'term-mode-hook 'ash-term-hooks)

(global-set-key [f1] (lambda () (interactive) (switch-to-buffer "*ansi-term*")))
(global-set-key [f2] (lambda () (interactive) (switch-to-buffer "*ansi-term*<2>")))

(provide 'ash-term)