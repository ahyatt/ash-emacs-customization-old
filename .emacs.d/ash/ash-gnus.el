;(require 'gnus-load)

(setq bbdb-always-add-addresses 'ash-add-addresses-p)
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-completion-display-record nil)
(setq bbdb-silent-running t)
(setq bbdb-use-pop-up nil)
(setq bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook)
(setq bbdb/news-auto-create-p 'bbdb-ignore-some-messages-hook)

(setq mm-text-html-renderer 'w3m-standalone)
(setq gnus-message-archive-group "Sent")

;; '(bbdb-extract-address-component-ignore-regexp "\\(\\(undisclosed\\|unlisted\\)[^,]*recipients\\)\\|no To-header on input|buganizer")


(defvar ash-last-mail-check (current-time))
(defvar ash-old-background-color nil)

;; (defadvice gnus-group-get-new-news (before mail-freq-warning
;; 					   first
;; 					   (&optional arg)
;; 					   activate) 
;;   " A function to help me stop checking mail so often.  Based on
;;  an Arthur Gleckler customization for his (different) mail
;;  reader."

;;   (when (< (time-to-seconds (time-since ash-last-mail-check)) (* 60 60))
;;     (unless ash-old-background-color
;;       (setq ash-old-background-color
;; 	    (cdr (assoc 'background-color (frame-parameters)))))
;;     (set-background-color "red")
;;     (run-at-time "5 min" nil
;; 		 (lambda ()
;; 		   (set-background-color ash-old-background-color))))
;;   (setq ash-last-mail-check (current-time)))

(provide 'ash-gnus)