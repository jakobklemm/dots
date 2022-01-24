(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-f") 'yas-expand)

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x j") 'kill-buffer-and-window)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x l") 'display-line-numbers-mode)

(global-set-key (kbd "C-§") 'popper-toggle-latest)
(global-set-key (kbd "M-§") 'popper-toggle-type)

(use-package evil
  :custom ((evil-move-cursor-back nil)
           (evil-move-beyond-eol t)
           (evil-ex-complete-emacs-commands nil)
           (evil-vsplit-window-right t)
           (evil-split-window-below t)
           )
  :config (evil-mode 1)
  :diminish (undo-tree-mode)
  :init (setq evil-want-keybinding nil)
  )

(use-package evil-collection
  :config (evil-collection-init)
  )

(use-package evil-commentary
  :config
  (evil-commentary-mode)
  )

(use-package evil-nerd-commenter
  :defer t
  )

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  (define-key evil-normal-state-map (kbd "gs") 'evil-surround-change)
  )

(require 'evil-dvorak)
;;(global-evil-dvorak-mode 1)

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  )

(evil-leader/set-leader ",")

(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

(evil-leader/set-key
  "cc" 'evilnc-comment-or-uncomment-lines
  "cp" 'evilnc-copy-and-comment-lines
  "cr" 'comment-or-uncomment-region
)
