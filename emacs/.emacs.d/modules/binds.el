;; Binds

(use-package evil
  :init
  (setq evil-respect-visual-line t)
  (setq evil-want-keybinding nil)
  :custom
  ((evil-want-integration nil)
   (evil-operator-state-cursor nil)
   (evil-jump-cross-buffers t)
   (evil-split-window-below t)
   (evil-vsplit-window-right t)
   (evil-search-module 'evil-search)
   (evil-move-beyond-eol t)
   (evil-want-Y-yank-to-eol t)
   )
  :config
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))

  (evil-mode)
  )

(use-package general)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 0.5))
  )

(general-define-key
 "C-x j" 'kill-buffer-and-window
 "C-c C-f" 'format-all-buffer
 "C-c C-o" 'general-override-local-mode
 )

(provide 'binds)
