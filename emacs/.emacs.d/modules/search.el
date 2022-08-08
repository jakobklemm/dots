;; Search

(use-package helm
  :config
  (helm-autoresize-mode 1)
  )

(use-package helm-rg
  :custom
  ((helm-rg-default-directory "~/org/"))
  )

(provide 'search)
