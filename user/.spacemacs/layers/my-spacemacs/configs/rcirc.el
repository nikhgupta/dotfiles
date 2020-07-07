(with-eval-after-load
  'rcirc (progn
           (setq rcirc-server-alist
                 `(("irc.gitter.im"
                    :user ,(getenv "GITTER_USER")
                    :port 6697 :encryption tls
                    :password ,(getenv "GITTER_TOKEN")
                    :channels ("#rails/rails #syl20bnr/spacemacs #gitterHQ/gitter"))
                   ("irc.freenode.net"
                    :user ,(getenv "FREENODE_USER")
                    :port 6697 :encryption tls
                    :password ,(getenv "FREENODE_TOKEN")
                    :channels ("#emacs #ruby #gnu"))))))
