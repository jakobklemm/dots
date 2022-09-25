;; LSP

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3)
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  )

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :custom
  ((lsp-keymap-prefix "C-c l")
   (lsp-headerline-breadcrumb-enable nil)
   (lsp-signature-auto-activate nil)
   (lsp-idle-delay 0.6)
   (lsp-rust-analyzer-server-display-inlay-hints t)
   (lsp-rust-analyzer-inlay-hints-mode t))
  :hook
  (elixir-mode . lsp)
  (rustic-mode . lsp)
  :config
  (lsp-enable-which-key-integration t)
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
  ((lsp-ui-doc-max-height 256)
   (lsp-ui-doc-max-width 64)
   (lsp-ui-doc-position 'bottom-and-right)
   (lsp-ui-doc-show-with-mouse t)
   (lsp-ui-doc-show-with-cursor t)
   (lsp-ui-doc-delay 1)
   )
  :config
  (lsp-ui-doc-enable t)
  (lsp-ui-mode)
  )

(provide 'jk-lsp)
