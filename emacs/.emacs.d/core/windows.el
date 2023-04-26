;; Windows

(use-package ace-window
  :init
  (setq aw-scope 'frame
	aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)))

(global-set-key (kbd "C-x o") 'ace-window)

(use-package transpose-frame
  )

(defun hrs/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  (ivy-switch-buffer)
  )

(defun hrs/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  (ivy-switch-buffer)
  )

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)

(use-package popper
  :bind (("C-,"   . popper-toggle-latest)
         ("M-,"   . popper-cycle)
         ("C-M-," . popper-toggle-type))
  :custom
  ((popper-reference-buffers
    '("\\*Messages\\*"
      "Output\\*$"
      "\\*Async Shell Command\\*"
      help-mode
      compilation-mode)))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(global-set-key (kbd "C-x j") 'kill-buffer-and-window)

(use-package centaur-tabs
  :demand
  :custom
  ((centaur-tabs-style "rounded")
   (centaur-tabs-height 42)
   (centaur-tabs-set-icons t)
   (centaur-tabs-set-modified-marker t)
   (centaur-tabs-modified-marker "*")
   )
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<left>" . centaur-tabs-backward)
  ("C-<right>" . centaur-tabs-forward)
  )

(provide 'windows)
