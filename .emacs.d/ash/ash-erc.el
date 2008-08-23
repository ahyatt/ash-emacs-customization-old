(require 'erc)

(setq erc-modules '(autoaway autojoin completion fill irccontrols log match menu move-to-prompt noncommands notify readonly ring scrolltobottom smiley stamp track)
      erc-hide-list (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE"))
      erc-autoaway-mode t
      erc-notify-mode t
      erc-echo-notices-in-minibuffer-flag t
      erc-auto-query 'window-noselect
      erc-autoaway-idletimer 'emacs
      erc-user-full-name user-full-name
      erc-track-when-inactive 'nil
      erc-track-exclude-types '(("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
      erc-track-exclude-server-buffer t
      erc-track-showcount t)

(provide 'ash-erc)