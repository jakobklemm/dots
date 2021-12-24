(use-package evil
  :diminish (undo-tree-mode)
  :init
  (setq evil-want-keybinding nil)
  :custom
  ((evil-move-cursor-back nil)
   (evil-move-beyond-eol t)
   (evil-ex-complete-emacs-commands nil)
   (evil-vsplit-window-right t)
   (evil-split-window-below t))
  :config
  (evil-mode 1)
  (use-package evil-goggles
    :defer t
    :custom
    ((evil-goggles-pulse t)
     (evil-goggles-duration 0.100))
    :config
    (evil-goggles-mode)
    (evil-goggles-use-diff-faces)
    )
  (use-package evil-collection
    :defer t
    :config
    (evil-collection-init)
    )
  (use-package evil-org
    :defer t
    :after org
    :hook (org-mode . (lambda () evil-org-mode))
    )
  (use-package evil-surround
    :defer t
    :config
    (global-evil-surround-mode 1)
    )
  )
