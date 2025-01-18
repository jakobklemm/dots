;; Programming

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package rust-ts-mode
  :hook
  ((rust-ts-mode . prettify-symbols-mode))
  )

(use-package rust-auto-use
  :hook
  
  )

(use-package toml-mode)

(use-package flycheck-rust
  :defer t
  :after flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

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
