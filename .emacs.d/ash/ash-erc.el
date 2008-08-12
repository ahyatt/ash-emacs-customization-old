(require 'erc)
(require 'erc-page-me)

(setq ash-erc-mode-line-string '(" "))
(add-to-list 'global-mode-string 'ash-erc-mode-line-string t)

(setq erc-modules '(autoaway autojoin completion fill irccontrols log match menu move-to-prompt noncommands notify readonly ring scrolltobottom smiley stamp track)
      erc-email-userid "ahyatt"
      erc-hide-list (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE"
                            "301" "305" "306" "317"
                            "324" "329" "332" "333" "353" "477"))
      erc-autoaway-mode t
      erc-notify-mode t
      erc-track-when-inactive nil
      erc-user-full-name "Andrew Hyatt"
      erc-track-exclude-server-buffer t
      erc-track-showcount t
      erc-notify-signoff-hook '(erc-notify-signoff)
      erc-notify-signon-hook '(erc-notify-signon)
      


(provide 'ash-erc)