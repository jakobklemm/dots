(use-package no-littering
  :defer t
  )

(column-number-mode)

(global-so-long-mode t)

(use-package eshell
  :bind (("C-x t" . eshell))
  )

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer))
  )
