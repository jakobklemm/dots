(use-package speed-type
  :defer t
  :commands (speed-type-text))

(use-package malyon
  :defer t
  )

(use-package tetris
  :ensure nil
  :commands (tetris)
  :bind
  (:map tetris-mode-map
        ("C-p" . tetris-rotate-prev)
        ("C-n" . tetris-rotate-down)
        ("C-b" . tetris-move-left)
        ("C-f" . tetris-move-right)
        ("C-SPC" . tetris-move-bottom))
  :config
  (defadvice tetris-end-game (around zap-scores activate)
    (save-window-excursion ad-do-it)))

(use-package 2048-game
  :commands (2048-game))

(use-package pdf-tools
  :mode "\\.pdf\\'"
  :custom
  (TeX-view-program-selection '((output-pdf "pdf-tools")))
  (TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
  :hook
  (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))
  :config
  (pdf-loader-install))
