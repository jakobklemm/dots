;; Core config, more advanced than defaults since packages get loaded

(use-package emacs
  :custom
  ((user-full-name "Jakob Klemm")
   (user-mail-address "github@jeykey.net")
   ;; Remember opened files.
   (desktop-dirname "~/.emacs.d/desktop/")
   (desktop-base-file-name "emacs.desktop")
   (desktop-base-lock-name "lock")
   (desktop-path (list "~/.emacs.d/desktop/"))
   (desktop-save t)
   (desktop-files-not-to-save   "^$")
   (desktop-load-locked-desktop nil)
   (desktop-auto-save-timeout   30))
  :config
  (desktop-save-mode 1)
  )

(use-package no-littering)

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.3))
  )

(column-number-mode)
