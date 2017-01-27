;;; packages.el --- my-spacemacs Layer packages File for Spacemacs

;;; Commentary:
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;;; Code:

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
;;
;; Note: yaml-mode is included inside extra-langs layer
(defvar my-spacemacs-packages '())
(defvar my-spacemacs-excluded-packages '())
(load-file (concat my-dotspacemacs-layers-path "my-spacemacs/funcs.el"))

;; load all `*.el' files inside the given path
(load-directory (concat my-dotspacemacs-layers-path "my-spacemacs/configs"))

;; run all `pre-layer-*' functions and add all `post-layer-*' functions to
;; `after-init-hook'
;; Note: this must appear at the end of this file
(my-spacemacs/run-custom-layer-hooks)


;; Note: layer based hooks will work when layer is enabled, while for package
;; based hooks to work you must redefine them in packages list above.)
;; Note: post-layer and post-config hooks are primarily the same.
;; You can use the following hooks:
;;  pre-layer-<layer>:     config before loading layer packages
;;  pre-init-<package>:    config before requiring package
;;  post-init-<package>:   config after requiring package
;;  pre-config-<package>:  config before loading package
;;  post-config-<package>: config after loading package
;;  post-layer-<layer>:    config after loading layer packages
