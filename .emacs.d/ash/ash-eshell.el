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

;; Modified from a post by Steve Yegge
(defun make-eshell (name dir)
  "Create a shell in the specified directory DIR.
NAME is the shell buffer name."
  (save-excursion
    (unless (string-match "/$" dir)
      (setq dir (concat dir "/")))
    (let ((default-directory dir)
          (eshell-buffer-name name))
      (eshell t)
      (set-buffer name)
      (setq eshell-history-file-name (concat "~/.eshell/history." (substring name 1 (- (length name) 1)))))))

(run-with-idle-timer 30 t 'eshell-save-some-history)

(defun eshell-write-history (&optional filename append)
  "Writes the buffer's `eshell-history-ring' to a history file.
The name of the file is given by the variable
`eshell-history-file-name'.  The original contents of the file are
lost if `eshell-history-ring' is not empty.  If
`eshell-history-file-name' is nil this function does nothing.

Useful within process sentinels.

See also `eshell-read-history'."
  (let ((file (or filename eshell-history-file-name)))
    (cond
     ((or (null file)
	  (equal file "")
	  (null eshell-history-ring)
	  (ring-empty-p eshell-history-ring))
      nil)
     ((not (file-writable-p file))
      (message "Cannot write history file %s" file))
     (t
      (let* ((ring eshell-history-ring)
	     (index (ring-length ring)))
	;; Write it all out into a buffer first.  Much faster, but
	;; messier, than writing it one line at a time.
	(with-temp-buffer
	  (while (> index 0)
	    (setq index (1- index))
	    (let ((start (point)))
	      (insert (ring-ref ring index) ?\n)
	      (subst-char-in-region start (1- (point)) ?\n ?\177)))
	  (eshell-with-private-file-modes
	   (write-region (point-min) (point-max) file append
			 'no-message)))
        (with-temp-buffer
          (shell-command (concat "sort -u " file) (current-buffer))
	  (eshell-with-private-file-modes
           (write-region (point-min) (point-max) file nil
                         'no-message))))))))


(defun eshell-save-some-history ()
  "Save the history for any open Eshell buffers."
  (eshell-for buf (buffer-list)
    (if (buffer-live-p buf)
	(with-current-buffer buf
	  (if (and eshell-mode
		   eshell-history-file-name
		   eshell-save-history-on-exit
		   (or (eq eshell-save-history-on-exit t)
		       (y-or-n-p
			(format "Save input history for Eshell buffer `%s'? "
				(buffer-name buf)))))
	      (eshell-write-history nil t))))))

(setq eshell-prompt-function
  (lambda ()
    (concat (eshell/pwd) "\n" 
            (format-time-string "%Y-%m-%d %H:%M" (current-time))
      (if (= (user-uid) 0) " # " " $ "))))

(global-set-key [f1] (lambda () (interactive) (switch-to-buffer "*eshell*")))
(global-set-key [f2] (lambda () (interactive) (switch-to-buffer "*eshell*<2>")))

(provide 'ash-eshell)