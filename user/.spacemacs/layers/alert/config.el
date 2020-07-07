;;; config.el --- alert Layer config File for Spacemacs
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

(defvar alert-default-style 'message
  "Default style for displaying alert messages.
Possible values are:
- fringe:        Changes the current frame's fringe background color
- gntp:          Uses gntp, it requires gntp.el (see https://github.com/tekai/gntp.el)
- growl:         Uses Growl on OS X, if growlnotify is on the PATH
- ignore:        Ignores the alert entirely
- libnotify:     Uses libnotify if notify-send is on the PATH
- log:           Logs the alert text to *Alerts*, with a timestamp
- message:       Uses the Emacs `message' facility (default)
- notifications: Uses notifications library via D-Bus
- notifier:      Uses terminal-notifier on OS X, if it is on the PATH
- toaster:       Use the toast notification system")
