(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)

(setq-default indent-tabs-mode nil)

(use-package company)

(use-package lsp-mode
  :defer t
  :commands lsp
  :hook ((typescript-mode js2-mode web-mode) . lsp)
  :bind (:map lsp-mode-map
         ("TAB" . completion-at-point))
  :custom (lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
  :defer t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-show))


;; Let's run 8 checks at once instead.
(setq flymake-max-parallel-syntax-checks 8)

;; I don't want no steekin' limits.
(setq flymake-max-parallel-syntax-checks nil)

(use-package flymake
  :defer t
  :config
  (flymake-mode t)
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

;; Improve tramp performance
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

(use-package markdown-mode
  :defer t)
