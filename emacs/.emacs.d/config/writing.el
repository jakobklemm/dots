(defcustom perfect-margin-ignore-regexps
  '("^minibuf" "^[*]" "Minibuf" "[*]" "magit" "mu4e" ".el" ".rs" ".toml" ".go")
  "List of strings to determine if window is ignored.
Each string is used as regular expression to match the window buffer name."
  :group 'perfect-margin)

(defcustom perfect-margin-ignore-filters
  '(window-minibuffer-p)
  "List of functions to determine if window is ignored.
Each function is called with window as its sole arguemnt, returning a non-nil value indicate to ignore the window."
  :group 'perfect-margin)

(use-package perfect-margin
  :ensure t
  :config
  (perfect-margin-mode 1)
  )

(use-package org-modern
  :defer t
  :config
  (global-org-modern-mode)
  )

(use-package org-appear
  :defer t
  :hook (org-mode . org-appear-mode)
  :custom
  ((org-hide-emphasis-markers t)
	 (org-appear-autoemphasis t)
	 (org-appear-autolinks t)
	 (org-appear-autosubmarkers t))
  )

(setq-default org-startup-with-latex-preview t)

(use-package org-fragtog
  :defer t
  :hook (org-mode . org-fragtog-mode)
  :custom
  ((org-latex-preview-ltxpng-directory "~/.ltxpng/")))
