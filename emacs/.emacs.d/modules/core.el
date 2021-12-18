;; Core config, more advanced than defaults since packages get loaded

(desktop-save-mode t)

(use-package no-littering)

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.3))
  )

(column-number-mode)

