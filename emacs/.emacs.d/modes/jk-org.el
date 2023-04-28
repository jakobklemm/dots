;; org-mode

(use-package org
  :hook
  (org-mode . org-toggle-inline-images)
  (text-mode . flyspell-mode)
  (org-mode . flyspell-mode)
  :custom
  ((org-directory "~/org/")
   (org-agenda-files '("~/org/active/"))
   (org-ellipsis " ▼ ")
   (org-hide-emphasis-markers t)
   (org-src-window-setup 'current-window)
   (org-return-follows-link t)
   (org-confirm-babel-evaluate nil)
   (org-catch-invisible-edits 'smart)
   )
  :config
  (setq-default org-display-inline-images t)
  (setq-default org-startup-with-inline-images t)
  )

(require 'tempo)
(require 'org-tempo)

(use-package org-modern
  :config
  (global-org-modern-mode)
  )

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  ((org-hide-emphasis-markers t)
   (org-appear-autoemphasis t)
   (org-appear-autolinks t)
   (org-appear-autosubmarkers t))
  )

(setq-default org-startup-with-latex-preview t)

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :config
  (plist-put org-format-latex-options :scale 1.6)
  :custom
  ((org-latex-preview-ltxpng-directory "~/.ltxpng/")))

(provide 'jk-org)
