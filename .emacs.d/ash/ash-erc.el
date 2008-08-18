(require 'erc)
(require 'erc-page-me)

(setq erc-modules '(autoaway autojoin completion fill irccontrols log match menu move-to-prompt noncommands notify readonly ring scrolltobottom smiley stamp track)
      erc-hide-list (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE"
                            "301" "305" "306" "317"
                            "324" "329" "332" "333" "353" "477"))
      erc-autoaway-mode t
      erc-notify-mode t
      erc-track-when-inactive nil
      erc-echo-notices-in-minibuffer-flag t
      erc-auto-query 'window-noselect
      erc-autoaway-idletimer 'emacs
      erc-user-full-name user-full-name
      erc-track-exclude-server-buffer t
      erc-track-showcount t
      erc-notify-signoff-hook '(erc-notify-signoff)
      erc-notify-signon-hook '(erc-notify-signon))

(provide 'ash-erc)