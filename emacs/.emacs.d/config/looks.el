(use-package all-the-icons
  :defer t
  :if (window-system)
  )

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(require 'nano-modeline)
(nano-modeline-mode t)
