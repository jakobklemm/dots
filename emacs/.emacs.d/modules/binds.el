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

(provide 'binds)
