(with-eval-after-load
    'gist (progn
            (setq
             gist-view-gist t
             version-control-diff-tool 'diff-hl
             version-control-global-margin t)
            (when-gui-with-server
             (setq diff-hl-side 'right)
             (global-diff-hl-mode))))
