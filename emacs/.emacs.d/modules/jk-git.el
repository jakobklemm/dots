;; Magit

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

(provide 'jk-git)
