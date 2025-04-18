;; Defaults

(use-package emacs
  :defer t
  :custom
  (
   ;; temp files, backups
   (recentf-save-file "~/.emacs.d/etc/recentf")
   (backup-directory-alist
    `((".*" . ,temporary-file-directory)))
   (auto-save-file-name-transforms
    `((".*" ,temporary-file-direct)))
   (save-place-file "~/.emacs.d/etc/places")
   (backups-inhibted t)

   ;; editor settings
   (auto-fill-mode t)
   (delete-selection-mode t)
   (require-final-newline t)
   (show-paren-delay 0.0)
   (indent-tabs-mode t)
   (indent-line-function 'insert-tab)
   (fill-column 80)
   (display-line-numbers-type 'relative)
   
   ;; quality of life changes
   (confirm-kill-emacs 'y-or-n-p)
   (ring-belll-function 'ignore)
   (delete-by-moving-to-trash t)
   (vc-follow-symlinks t)
   (byte-compile-warnings '(cl-functions))
   (sentence-end-double-space nil)
   (truncate-lines t)
   (inhibit-startup-screen t)
   (confirm-kill-process nil)
   (mark-even-if-inactive nil)
   (history-delete-duplicates t)
   (mouse-yank-at-point t)
   (comp-async-report-warnings-errors nil)
   (initial-scratch-message nil)
   (confirm-nonexistent-file-or-buffer nil)
   )
  :hook
  ((text-mode . auto-fill-mode)
   (org-mode . auto-fill-mode))
  :init
  (show-paren-mode t)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (desktop-save-mode t)
  (save-place-mode t)
  (set-language-environment "UTF-8")
  (global-hl-line-mode t)
  (global-display-line-numbers-mode t)
  (prefer-coding-system       'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment   'utf-8)
  (auto-compression-mode 1)
  ;; (redisplay-dont-pause t)
  )

(use-package no-littering)

(use-package format-all)

(provide 'defaults)
