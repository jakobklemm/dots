;; Binds

(use-package general)

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.5))
  )

(provide 'jk-binds)
