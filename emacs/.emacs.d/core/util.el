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

(use-package ripgrep)

(use-package helpful)

(use-package popper
  :bind (("C-,"   . popper-toggle-latest)
         ("M-,"   . popper-cycle)
         ("C-M-," . popper-toggle-type))
  :custom
  ((popper-reference-buffers
    '("\\*Messages\\*"
      "Output\\*$"
      "\\*Async Shell Command\\*"
      help-mode
      compilation-mode)))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(provide 'util)
