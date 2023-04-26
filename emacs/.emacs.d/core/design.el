;; Design

(use-package doom-themes
  :config
  (load-theme 'doom-snazzy t)
  )

(use-package doom-modeline
  :config
  (doom-modeline-mode)
  )

(use-package rainbow-delimiters
  :hook
  ((org-mode . rainbow-delimiters-mode)
   (prog-mode . rainbow-delimiters-mode)))

(use-package pulsar
  :custom
  ((pulsar-pulse t)
   (pulsar-face 'pulsar-magenta)
   )
  :config
  (pulsar-global-mode 1)
  )

(use-package all-the-icons
  :if (window-system))

(provide 'design)
