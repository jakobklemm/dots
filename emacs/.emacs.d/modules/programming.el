(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)

(setq-default indent-tabs-mode nil)

(add-to-list 'exec-path "~/.tools/elixir-ls")

(use-package lsp-mode
  :defer t
  :commands lsp
  :custom
  (
   (lsp-ui-doc-max-height 52)
   (lsp-ui-doc-max-width 64)
   (lsp-ui-doc-position 'at-point)
   (lsp-ui-doc-position 'bottom)
   (lsp-ui-doc-show-with-mouse t)
   (lsp-ui-doc-show-with-cursor t)
   (lsp-headerline-breadcrumb-enable nil)
   (lsp-signature-auto-activate nil)
   (lsp-idle-delay 0.6)
   (lsp-rust-analyzer-server-display-inlay-hints t)
   (lsp-rust-analyzer-inlay-hints-mode t)
   )
  :hook
  (elixir-mode . lsp)
  (rustic-mode . lsp)
  )

(use-package lsp-ui
  :defer t
  :commands lsp-ui-mode
  :custom
  ((lsp-ui-doc-max-height 128)
   (lsp-ui-doc-max-width 64)
   (lsp-ui-doc-position 'top)
   (lsp-ui-doc-show-with-mouse t)
   (lsp-ui-doc-show-with-cursor t)
   )
  :config
  (lsp-ui-doc-enable t)
  (lsp-ui-mode)
  )

(use-package smartparens
  :defer t
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap))
  )

(use-package yasnippet
  :defer t
  :config
  (use-package yasnippet-snippets
    :defer t
    )
  (yas-global-mode 1)
  :custom
  ((yas-indent-line 'auto))
  )

(use-package format-all
  :defer 2
  :bind ("C-c C-f" . format-all-buffer)
  )

(use-package magit
  :defer t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x p") 'magit-init)
  (global-set-key (kbd "C-v") 'magit-commit)
  )

(use-package magit-todos
  :defer t
  :config
  (magit-todos-mode t)
  )

(use-package git-messenger
  :config
  (global-set-key (kbd "C-x m") 'git-messenger:popup-message)
  )

(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  )

;; Edit comments in dedicated buffers
(use-package separedit
  :defer t
  :config
  (define-key prog-mode-map        (kbd "C-c '") #'separedit)
  (define-key minibuffer-local-map (kbd "C-c '") #'separedit)
  (define-key help-mode-map        (kbd "C-c '") #'separedit)
  )

(use-package flycheck
  :defer 2
  )

(use-package rustic
  :defer 2
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
  :hook (rust-mode . cargo-minor-mode))

(use-package toml-mode
  :defer 2
  )
