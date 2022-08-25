;; Programming

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none)
  (lsp--auto-configure t)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-modeline-code-actions-enable nil)
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless)))
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))

(use-package lsp-ui
  :config
  (lsp-ui-mode t)
  (lsp-ui-doc-mode t)
  :custom
  (
   (lsp-ui-sideline-enable nil)
   (lsp-ui-enable t)
   (lsp-ui-doc-enable t)
   (lsp-ui-doc-position 'top)
   (lsp-ui-doc-delay 1.0)
   ))

(use-package format-all)

(use-package rustic
  :custom
  ((rustic-format-on-save t)
   (rustic-format-trigger 'on-save))
  :bind
  (:map rustic-mode-map
        ("M-j" . lsp-ui-imenu)
        ("M-?" . lsp-find-references)
        ("C-c C-c l" . flycheck-list-errors)
        ("C-c C-c a" . lsp-execute-code-action)
        ("C-c C-c r" . lsp-rename)
        ("C-c C-c q" . lsp-workspace-restart)
        ("C-c C-c Q" . lsp-workspace-shutdown)
        ("C-c C-c s" . lsp-rust-analyzer-status))
  :hook
  ((rustic-mode-hook . lsp)))

(use-package rust-auto-use
  :hook
  ((rust-mode-hook . rust-auto-use)))

(use-package toml-mode)

(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))

(use-package smartparens
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap))
  )

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x p") 'magit-init)
  (global-set-key (kbd "C-v") 'magit-commit)
  )

(use-package magit-todos
  :config
  (magit-todos-mode t)
  )

(use-package git-messenger
  :config
  (global-set-key (kbd "C-x m") 'git-messenger)
  )

(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

(provide 'programming)
