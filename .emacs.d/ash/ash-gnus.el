;(require 'gnus-load)

(set-face-foreground 'gnus-group-mail-3 "blue3")
(setq bbdb-always-add-addresses 'ash-add-addresses-p)
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-completion-display-record nil)
(setq bbdb-silent-running t)
(setq bbdb-use-pop-up nil)
(setq bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook)
(setq bbdb/news-auto-create-p 'bbdb-ignore-some-messages-hook)

(setq mm-text-html-renderer 'w3m-standalone)
(setq gnus-message-archive-group "Sent")

(setq gnus-agent-queue-mail nil)
(setq gnus-keep-same-level 't)

(setq gnus-group-use-permanent-levels 't)
(setq gnus-summary-line-format "%-10&user-date;%U%R%z%I%(%[%-23,23f%]%) %s\n")

;; From http://emacs.wordpress.com/2008/04/21/two-gnus-tricks/
(setq gnus-user-date-format-alist
      '(((gnus-seconds-today) . "Today, %H:%M")
        ((+ 86400 (gnus-seconds-today)) . "Yesterday, %H:%M")
        (604800 . "%A %H:%M") ;;that's one week
        ((gnus-seconds-month) . "%A %d")
        ((gnus-seconds-year) . "%B %d")
        (t . "%B %d '%y"))) ;;this one is used when no other does match

;; From http://www.emacswiki.org/emacs/init-gnus.el

(setq gnus-summary-line-format "%4P %U%R%z%O %{%16&user-date;%}   %{%-20,20n%} %{%ua%} %B %(%I%-60,60s%)\n")
(defun gnus-user-format-function-a (header) 
  (let ((myself (concat "<" user-mail-address ">"))
        (references (mail-header-references header))
        (message-id (mail-header-id header)))
    (if (or (and (stringp references)
                 (string-match myself references))
            (and (stringp message-id)
                 (string-match myself message-id)))
        "X" "│")))

(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-indent "    ")
(setq gnus-sum-thread-tree-single-indent "◎ ")
(setq gnus-sum-thread-tree-root "● ")
(setq gnus-sum-thread-tree-false-root "☆")
(setq gnus-sum-thread-tree-vertical "│")
(setq gnus-sum-thread-tree-leaf-with-other "├─► ")
(setq gnus-sum-thread-tree-single-leaf "╰─► ")


(defvar ash-last-mail-check (current-time))
(defvar ash-old-background-color nil)

(setq gnus-single-article-buffer nil)

(provide 'ash-gnus)
