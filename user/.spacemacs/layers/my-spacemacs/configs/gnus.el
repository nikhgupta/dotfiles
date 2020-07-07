(setq gnus-secondary-select-methods
      '((nntp "gmane" (nntp-address "news.gmane.org"))
        (nntp "news.eternal-september.org")
        (nntp "nntp.aioe.org")
        (nntp "news.gwene.org")))

;; Get email, and store in nnml
(setq gnus-secondary-select-methods
      '((nnimap "gmail" (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993) (nnimap-stream ssl))))

;; Send email via Gmail:
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.gmail.com")

;; Archive outgoing email in Sent folder on imap.gmail.com:
(setq gnus-message-archive-method '(nnimap "imap.gmail.com")
      gnus-message-archive-group "[Gmail]/Sent Mail")

;; set return email address based on incoming email address
(setq gnus-posting-styles
      '(((header "to" "mestoic@gmail.com") (address "mestoic@gmail.com"))
        ((header "to" "me@nikhgupta.com")  (address "me@nikhgupta.com"))))

;; store email in ~/gmail directory
(setq nnml-directory "~/.cache/gmail"
      message-directory "~/.cache/gmail")
