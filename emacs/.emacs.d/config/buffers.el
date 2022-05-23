
(use-package ibuffer
  :defer t
  :bind (("C-x C-b" . ibuffer))
  :init
  (add-hook 'ibuffer-mode-hook #'hl-line-mode))

(use-package popper
  :defer t
  :bind (("C-;"   . popper-toggle-latest)
         ("M-;"   . popper-cycle)
         ("C-M-;" . popper-toggle-type))
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
