(defcustom erc-ignore-content '()
  "Regular expressions to identify content to ignore.
           Usually what happens is that you add the bots to
           `erc-ignore-list' and the bot commands to this list."
  :group 'erc
  :type '(repeat regexp))

(with-eval-after-load
    'erc (progn
           (setq
            erc-modules (append erc-modules '(smiley spelling notifications))
            erc-autojoin-delay 5
            erc-keywords '()
            erc-max-buffer-size 20000
            erc-hide-timestamps t
            erc-truncate-buffer-on-save t
            erc-frame-dedicated-flag t
            erc-interpret-mirc-color t
            erc-auto-query 'window-noselect
            erc-format-nick-function 'erc-format-@nick
            erc-track-position-in-mode-line nil
            erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                      "324" "329" "332" "333" "353" "477")

            ;; erc-auto-query 'bury
            erc-fill-column 120
            erc-autojoin-timing 'ident
            erc-prompt-for-password nil
            erc-prompt-for-nickserv-password nil
            erc-hide-list '("JOIN" "PART" "QUIT" "NICK" "MODE"))

           ;; add some hooks to run on our erc server
           (add-hook 'erc-server-NOTICE-hook 'erc-auto-query)
           ;; (add-hook 'erc-join-hook 'my-erc/bitlbee-identify)
           (add-hook 'erc-after-connect 'my-erc/ghost-maybe)
           (add-hook 'erc-insert-pre-hook 'my-erc/ignore-content)
           (add-hook 'erc-insert-modify-hook 'my-erc/reformat-jabber-backlog)

           ;; activate some minor modes for erc
           (erc-log-mode 1)
           (erc-fill-mode 1)
           (erc-autojoin-mode 1)
           (erc-autoaway-mode 1)
           (erc-spelling-mode 1)
           (erc-scrolltobottom-enable)

           (evil-leader/set-key "aii" 'my-spacemacs/irc)
           (if (daemonp) (my-spacemacs/open-irc))))

(defun my-spacemacs/irc ()
  "Connect to IRC."
  (interactive)
  (if (get-buffer "irc.freenode.net:6697")
      (erc-track-switch-buffer 1)
    (when (or (daemonp) (y-or-n-p "Start IRC?"))
      (my-spacemacs/open-irc))))

(defun my-spacemacs/open-irc(&rest body)
  "Join a few servers on IRC if we are not already connected to them. Otherwise,
  if we are in daemon mode, connect to these servers in IRC. If we are not running
  as daemon, ask the user if he really wants to connect to IRC?"

  (erc-tls :server "irc.gitter.im" :port 6697
           :full-name (getenv "NAME")
           :nick (getenv "GITTER_USER")
           :password (getenv "GITTER_TOKEN"))
  (erc     :server "localhost" :port 6667
           :full-name (getenv "NAME")
           :nick (getenv "BITLBEE_USER"))
  (erc-tls :server "irc.freenode.net" :port 6697
           :full-name (getenv "NAME")
           :nick (getenv "FREENODE_USER")
           :password (getenv "FREENODE_TOKEN")))

(defun my-erc/reformat-jabber-backlog ()
  "Fix \"unkown participant\" backlog messages from bitlbee."
  (save-excursion
    (goto-char (point-min))
    (if (looking-at
         "^<root> Message from unknown participant \\([^:]+\\):")
        (replace-match "<\\1>"))))

(defun my-erc/bitlbee-identify ()
  "If we're on the bitlbee server, send the identify command to the 
  &bitlbee channel."
  (when (and (string= "localhost" erc-session-server)
             (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify %s"
                                   (erc-default-target)
                                   (getenv "BITLBEE_TOKEN")))))

;; (defun erc-cmd-TWITTER (name)
;;   (interactive)
;;   (setq-local twurl "https://widget-data-feeder.herokuapp.com/twitter/info/")
;;   (with-current-buffer
;;       (url-retrieve
;;        (concat twurl name)
;;        (message (buffer-string))
;;        (lambda(status) (erc-display-line  'active)))))

(defadvice my-erc/display-prompt (after conversation-erc-display-prompt activate)
  "Insert last recipient after prompt."
  (let ((previous
         (save-excursion
           (if (and (search-backward-regexp (concat "^[^<]*<" erc-nick ">") nil t)
                    (search-forward-regexp (concat "^[^<]*<" erc-nick ">"
                                                   " *\\([^:]*: ?\\)") nil t))
               (match-string 1)))))
    ;; when we got something, and it was in the last 3 mins, put it in
    (when (and
           previous
           (> 180 (time-to-seconds
                   (time-since (get-text-property 0 'timestamp previous)))))
      (set-text-properties 0 (length previous) nil previous)
      (insert previous))))

(defun my-erc/ghost-maybe (server nick)
  "Send GHOST message to NickServ if NICK ends with `erc-nick-uniquifier'.
  The function is suitable for `erc-after-connect'."
  (when (string-match (format "\\(.*?\\)%s+$" erc-nick-uniquifier) nick)
    (let ((nick-orig (match-string 1 nick)) (password erc-session-password))
      (erc-message "PRIVMSG" (format "NickServ GHOST %s %s"
                                     nick-orig password))
      (erc-cmd-NICK nick-orig)
      (erc-message "PRIVMSG" (format "NickServ identify %s %s" nick-orig password)))))

; (defun my-erc/buffer-prompt()
;   (cond ((equal (buffer-name) "#twitter_nikhgupta") "[#twitter]")
;         ((equal (buffer-name) "#twitter_journalofnikhil") "[#journal]")
;         (t (concat "[" (buffer-name) "]"))))

(defun my-erc/ignore-content (msg)
  "Check whether MSG is to be ignored."
  (when
      (erc-list-match erc-ignore-content msg)
    (setq erc-insert-this nil)))
