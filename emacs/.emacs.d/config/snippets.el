(use-package yasnippet
  :defer t
  :config
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-f") 'yas-expand)
  )

(use-package yasnippet-snippets
  :defer t
  )

(yas-global-mode t)
