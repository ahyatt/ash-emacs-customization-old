(setq load-path (append '("~/.emacs.d/ash"
                          "~/.emacs.d/misc"
                          "~/.emacs.d/bbdb"
                          "~/.emacs.d/elib"
                          "~/.emacs.d/remember"
                          "~/.emacs.d/org-mode/lisp"
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
(require 'ash-term)
(require 'ash-java)
(require 'ash-erc)
(require 'w3m-load)
(require 'ash-faces)
(require 'git)

(server-start)