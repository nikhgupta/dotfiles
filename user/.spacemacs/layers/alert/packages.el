;;; packages.el --- alert Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq alert-packages '(alert erc rcirc-notify))
(setq alert-excluded-packages '())

(defun alert/init-alert()
  (use-package alert
    :defer t
    :init
    (when (and (spacemacs/system-is-mac) (equalp alert-default-style 'notifications))
      (spacemacs-buffer/warning "Unable to use `notifications' type alert on OSX. Reverting to `messages'")
      (setq alert-default-style 'message))))

(defun alert/post-init-erc()
  (with-eval-after-load 'erc
    (if (spacemacs/system-is-mac) (erc-notifications-mode -1))
    (defun erc-global-notify (match-type nick message)
      (alert message
             :title (concat (buffer-name) "@" erc-session-server)))))

;; todo: somehow this does not work in RCIRC :(
(defun alert/post-init-rcirc-notify()
  (eval-after-load 'rcirc '(rcirc-notify-add-hooks))
  (with-eval-after-load 'rcirc-notify
    (add-hook 'rcirc-notify-page-me-hooks
              '(lambda(message)
                 (alert message
                        :title (concat (buffer-name "@" rcirc-server-name)))))))
