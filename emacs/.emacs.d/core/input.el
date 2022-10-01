;; Base input setup

(use-package general)
(use-package evil
  :init
  (setq evil-want-fine-undo t)
  (setq evil-want-keybinding nil)
  (setq evil-move-beyond-eol t)
  (setq evil-want-Y-yant-to-eol t)
  (setq evil-move-cursor-back nil)
  )

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
 "C-x 3" 'hrs/split-window-right-and-switch
 "C-x 2" 'hrs/split-window-below-and-switch
 "C-c C-f" 'format-all-buffer
 "C-c C-o" 'general-override-local-mode
 )

(provide 'input)
