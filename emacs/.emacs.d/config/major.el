;; Collection of progrmaming major modes

(use-package web-mode
  :defer t
  :config
  (add-hook 'web-mode-hook
            (lambda ()
              (rainbow-mode)
              (rspec-mode)
              (setq web-mode-markup-indent-offset 2)))
  )

(use-package elixir-mode
  :defer t
  )

(use-package markdown-mode
  :defer t
  )

(use-package systemd
  :defer t
  :mode
  ("\\.service\\'" "\\.timer\\'" "\\.target\\'" "\\.mount\\'"
   "\\.automount\\'" "\\.slice\\'" "\\.socket\\'" "\\.path\\'"
   "\\.netdev\\'" "\\.network\\'" "\\.link\\'"))

(use-package yaml-mode
  :defer t
  :mode ("\\.yaml\\'" "\\.yml\\'")
  :custom-face
  (font-lock-variable-name-face ((t (:foreground "violet"))))
  )

(use-package haskell-mode
  :defer t
  )

(use-package go-mode
  :defer t
  )

(use-package hindent
  :defer t
  )

(use-package csharp-mode
  :defer t
  )

(use-package csv-mode
  :defer 2
  )

(use-package conf-mode
  :defer t
  )
