;; Org

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
  (require 'tempo)
  (require 'org-tempo)
  )

(use-package org-modern
  :config
  (global-org-modern-mode)
  )

(use-package org-transclusion)

;; ;; https://stackoverflow.com/questions/13340616/assign-ids-to-every-entry-in-org-mode
;; (defun my/org-add-ids-to-headlines-in-file ()
;;   "Add ID properties to all headlines in the current file which
;; do not already have one."
;;   (interactive)
;;   (org-map-entries 'org-id-get-create))

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook 'my/org-add-ids-to-headlines-in-file nil 'local)))

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
  (plist-put org-format-latex-options :scale 1.5)
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
