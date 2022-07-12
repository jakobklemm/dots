;; windows.el

(use-package ace-window
  :defer t
  :init
  (setq aw-scope 'frame ; limit to single frame
	    aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)
	    )
  )

(defun hrs/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  (consult-buffer)
  )

(defun hrs/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  (consult-buffer)
  )

(provide 'windows)
