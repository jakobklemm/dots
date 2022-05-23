(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :custom
  ((which-key-idle-delay 1.0))
  )

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x j") 'kill-buffer-and-window)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x l") 'display-line-numbers-mode)

(global-set-key (kbd "C-§") 'popper-toggle-latest)
(global-set-key (kbd "M-§") 'popper-toggle-type)

(global-set-key (kbd "C-;") 'popper-toggle-latest)
(global-set-key (kbd "M-;") 'popper-toggle-type)

(global-set-key (kbd "C-c c") 'global-evil-dvorak-mode)

(global-set-key (kbd "C-c b") 'org-toggle-checkbox)
