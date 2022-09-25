;; Org

(use-package org
  :hook
  (org-mode . org-toggle-inline-images)
  (org-mode . org-indent-mode)
  (text-mode . flyspell-mode)
  (org-mode . flyspell-mode)
  :custom
  ((org-directory "~/org/")
   (org-agenda-files '("~/org/active/"))
   (org-image-actual-width '(600))
   (org-ellipsis " ▼ ")
   (org-adapt-indentation nil)
   (org-fontify-quote-and-verse-blocks t)
   (org-startup-folded t)
   (org-src-tab-acts-natively t)
   (org-hide-emphasis-markers t)
   (org-src-window-setup 'current-window)
   (org-return-follows-link t)
   (org-confirm-babel-evaluate nil)
   (org-use-speed-commands t)
   (org-catch-invisible-edits 'show)
   )
  :config
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.60))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.40))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.20))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
   )
  (setq-default org-display-inline-images t)
  (setq-default org-startup-with-inline-images t)
  (require 'tempo)
  (require 'org-tempo)
  )

(use-package org-modern
  :config
  (global-org-modern-mode)
  )

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  ((org-hide-emphasis-markers t)
   (org-appear-autoemphasis t)
   (org-appear-autolinks nil)
   (org-appear-autosubmarkers t))
  )

(setq-default org-startup-with-latex-preview t)

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :custom
  ((org-latex-preview-ltxpng-directory "~/.ltxpng/")))

(use-package ob-rust)
(use-package ob-go)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (latex . t)
   (rust . t)
   ))

(require 'org-mouse)

(provide 'jk-org)
