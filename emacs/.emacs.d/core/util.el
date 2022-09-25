;; Utility packages

(use-package savehist
  :init
  (savehist-mode)
  )

(use-package all-the-icons
  :if (window-system))

(pixel-scroll-precision-mode t)
(setq pixel-scroll-precision-large-scroll-height 40.0)
(setq pixel-scroll-precision-interpolation-factor 30)
(setq scroll-margin 30)

(provide 'util)
