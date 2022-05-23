(use-package rustic
  :defer t
  :bind (:map rustic-mode-map
              ("C-c r" . rustic-cargo-run)
              ("C-c C-r" . lsp-rename)
              ("C-c C-c s" . lsp-rust-analyzer-status)
              )
  :custom
  ((rustic-format-on-save t))
  )

(use-package cargo
  :defer 2
  :hook (rust-mode . cargo-minor-mode)
  )

(use-package toml-mode
  :defer 2
  )
