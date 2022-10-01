;; Windows

(use-package ace-window
  :init
  (setq aw-scope 'frame
	    aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)))

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

(provide 'windows)
