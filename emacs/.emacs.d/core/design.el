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

(use-package beacon
  :custom
  ((beacon-blink-when-window-scrolls nil)
   )
  :hook
  ((after-init . beacon-mode))
  )

(provide 'design)
