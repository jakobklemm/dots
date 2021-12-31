;; Core config, more advanced than defaults since packages get loaded

(setq user-full-name "Jakob Klemm"
      user-mail-address "jakob@jeykey.net")

(setq smtpmail-smtp-server "mail.cyon.ch"
      smtpmail-smtp-service 465
      message-send-mail-function 'smtpmail-send-it)

(desktop-save-mode t)

(use-package no-littering)

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 1.0))
  )

(use-package eshell
  :bind (("C-x t" . eshell))
  )

(column-number-mode)

(global-so-long-mode t)

(defun hrs/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  (counsel-switch-buffer)
  )

(defun hrs/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  (counsel-switch-buffer)
  )

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

