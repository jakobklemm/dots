;; Rust

(use-package rustic
  :custom
  ((rustic-format-on-save t)
   (rustic-format-trigger 'on-save)
   (rustic-lsp-client 'eglot)
   )
  :bind
  (:map rustic-mode-map
        ("C-c C-c l" . flycheck-list-errors)
        )
  :hook
  ((rustic-mode-hook . lsp)))

(use-package flycheck-rust
  :config
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  )

(use-package rust-auto-use
  :hook
  ((rust-mode-hook . rust-auto-use)))

(use-package toml-mode)

(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))

(provide 'jk-rust)
