;; Utility packages

(use-package savehist
  :init
  (savehist-mode)
  )

(use-package all-the-icons
  :if (window-system))

(provide 'util)
