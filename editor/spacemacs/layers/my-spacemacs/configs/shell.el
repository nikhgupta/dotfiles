(with-eval-after-load
  'shell (progn
           (add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
           (add-hook 'sh-mode-hook
                     (lambda ()
                       (if (string-match "\\.zsh$" buffer-file-name)
                         (sh-set-shell "zsh"))))))
