;;; keybindings.el --- my-spacemacs Layer keybindings File for Spacemacs
;;
;; Copyright (c) 2015 Nikhil Gupta
;;
;; Author: Nikhil Gupta <me@nikhgupta.com>
;; URL: https://github.com/nikhgupta/dotfiles
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Reference URLs:
;;  list of evil-maps: https://github.com/emacsmirror/evil/blob/master/evil-maps.el

;;; EaseSpacemacs
;; Since I never use the ; key anyway, this is a real optimization for almost
;; all Vim commands, since we don't have to press that annoying Shift key that
;; slows the commands down
(define-key evil-normal-state-map ";" 'evil-ex)

;; define some other operators/maps essential to vim-emacs transformation
(define-key evil-normal-state-map "gx" 'browse-url-at-point)

;; switch implementations of ^ and 0
(define-key evil-motion-state-map "0"  'evil-first-non-blank)
(define-key evil-motion-state-map "^"  'evil-digit-argument-or-evil-beginning-of-line)
;;;; FIXME: the following 2 mappings seem extraneous and are useful only if they move to
;;;; the beginning of visual region.
;;;; Otherwise, they just work like the above 2 mappings.
;; (define-key evil-motion-state-map "g0" 'evil-first-non-blank-of-visual-line)
;; (define-key evil-motion-state-map "g^" 'evil-beginning-of-visual-line)

(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)

;; use <leader>; to open helm M-x menu, thereby saving a Shift keypress, again.
(evil-leader/set-key ";" 'helm-M-x)
;; use <leader>` to open shell (<leader>' does the same)
(evil-leader/set-key "`" 'spacemacs/default-pop-shell)

;; split window functions 
(evil-leader/set-key "w-" 'split-window-below-and-focus)
(evil-leader/set-key "w/" 'split-window-right-and-focus)

;;; OwnerGroup
(spacemacs/declare-prefix "o"  "own/org/open/others")
(spacemacs/declare-prefix "ob" "open-special-buffer")
(spacemacs/declare-prefix "ox" "org-mode")
;; (spacemacs/declare-prefix "oh" "help")

;; prefix for opening special buffers wherever we are in Emacs.
(evil-leader/set-key "obm" 'my-spacemacs/open-messages)
(evil-leader/set-key "obh" 'my-spacemacs/open-spacemacs)
(evil-leader/set-key "obc" 'my-spacemacs/open-changelog)
(evil-leader/set-key "obs" 'my-spacemacs/open-scratch)

;; get help easily
(evil-leader/set-key "hda" 'helm-apropos)

;; vim key bindings
;; dont use them as they are brittle
(evil-leader/set-key "b=" "ggVG=")
