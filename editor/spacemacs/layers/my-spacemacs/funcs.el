;;; funcs.el --- my-spacemacs Layer funcs File for Spacemacs
;;
;; Copyright (c) 2015 Nikhil Gupta
;;
;; Author: Nikhil Gupta <me@nikhgupta.com>
;; URL: https://github.com/nikhgupta/dotfiles
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; add custom hooks (always run) to work before and after loading a layer
(defun my-spacemacs/run-custom-layer-hooks()
  (dolist (layer (delete-dups (mapcar (lambda (l) (if (listp l) (car l) l))
                                      dotspacemacs-configuration-layers)))
    (setq-local pre-layer  (intern (format "my-spacemacs/pre-layer-%s" layer)))
    (setq-local post-layer (intern (format "my-spacemacs/post-layer-%s" layer)))
    (if (fboundp pre-layer) (funcall pre-layer))
    (if (fboundp post-layer) (add-hook 'after-init-hook post-layer))))

(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))

;; keybindings related functions
(defun my-spacemacs/open-messages()
  (interactive)
  (switch-to-buffer-other-window "*Messages*" t))
(defun my-spacemacs/open-spacemacs()
  (interactive)
  (switch-to-buffer-other-window "*spacemacs*" t))
(defun my-spacemacs/open-changelog()
  (interactive)
  (find-file-other-window
   (expand-file-name "~/.emacs.d/CHANGELOG.org" t)))
(defun my-spacemacs/open-scratch()
  (interactive)
  (switch-to-buffer-other-window "*scratch*" t))
