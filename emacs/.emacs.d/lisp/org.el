(use-package org
  :defer t
  :hook
  (org-mode . org-toggle-inline-images)
  (org-mode . org-indent-mode)
  (text-mode . flyspell-mode)
  (org-mode . flyspell-mode)
  :custom
  ((org-directory "~/documents/")
   (org-archive-location "~/archive/2021.org::* From %s")
   (org-agenda-files '("~/supervisor/supervisor.org"))
   (org-image-actual-width '(600))
   (org-ellipsis " ▼ ")
   (org-adapt-indentation nil)
   (org-fontify-quote-and-verse-blocks t)
   (org-startup-folded t)
   (org-priority-highest ?A)
   (org-priority-lowest ?C)
   (org-priority-faces
    '((?A . 'all-the-icons-red)
      (?B . 'all-the-icons-orange)
      (?C . 'all-the-icons-yellow)))
   (org-src-tab-acts-natively t)
   (org-hide-emphasis-markers t)
   (org-src-window-setup 'current-window)
   (org-return-follows-link t)
   (org-confirm-babel-evaluate nil)
   (org-use-speed-commands t)
   (org-catch-invisible-edits 'show)
   (ispell-program-name "hunspell")
   (ispell-local-dictionary "de_DE")
   (ispell-local-dictionary-alist
    '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
      ("de_DE" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE" "-a" "-i" "UTF-8") nil utf-8)))
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
  (add-hook 'ispell-change-dictionary-hook #'flyspell-buffer)
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

(use-package org-superstar
  :defer t
  :hook (org-mode . (lambda () (org-superstar-mode 1)))
  :custom
  ((org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶"))
   (org-superstar-prettify-item-bullets t)
   (org-superstar-configure-like-org-bullets t)
   (org-hide-leading-stars nil)
   (org-superstar-leading-bullet ?\s)
   (org-superstar-special-todo-items t)
   ))

(use-package org-fragtog
  :defer t
  :hook (org-mode . org-fragtog-mode)
  :custom
  ((org-latex-preview-ltxpng-directory "~/.ltxpng/")))

;; Additional files
(load-file (concat user-emacs-directory "lisp/org-checklist-plus.el"))
(load-file (concat user-emacs-directory "lisp/org-content.el"))
(load-file (concat user-emacs-directory "lisp/org-export.el"))
(load-file (concat user-emacs-directory "lisp/org-active.el"))
