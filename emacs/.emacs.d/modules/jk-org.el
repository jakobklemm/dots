;; Orgmode

(use-package org
  :hook
  (org-mode . org-toggle-inline-images)
  (text-mode . flyspell-mode)
  (org-mode . flyspell-mode)
  :custom
  ((org-directory "~/org/")
   (org-agenda-files '("~/org/"))
   (org-ellipsis " ▼ ")
   (org-hide-emphasis-markers t)
   (org-src-window-setup 'current-window)
   (org-return-follows-link t)
   (org-confirm-babel-evaluate nil)
   (org-catch-invisible-edits 'smart)
   (org-archive-location "~/org/archive/2023.org::* From %s")
   )
  :config
  (setq-default org-display-inline-images t)
  (setq-default org-startup-with-inline-images t)
  (require 'tempo)
  (require 'org-tempo)
  (require 'org-mouse)
  )

(use-package org-modern
  :config
  (global-org-modern-mode)
  )

(setq org-log-done 'time
      org-log-redeadline 'time
      org-log-refile 'time
      )

(use-package org-transclusion)

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
  (
   (org-latex-preview-ltxpng-directory "~/.ltxpng/")
   )
  )

;; https://github.com/Civitasv/runemacs
(defun civ/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . civ/org-mode-visual-fill))

(use-package ob-rust)
(use-package ob-go)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (latex . t)
   (rust . t)
   ))

(use-package org-roam
  :custom
  (
   (org-roam-db-location "~/Documents/org-roam.db")
   (org-roam-directory "~/org/database/")
   (org-roam-v2-ack t)
   (org-roam-completion-everywhere t)
   (org-roam-capture-templates '(
				 ("d" "Direct" plain
				  "%?"
				  :if-new (file+head "main/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE:"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
                 ("e" "ETH" plain
				  "%?"
				  :if-new (file+head "eth/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
                 ("t" "Tech" plain
				  "%?"
				  :if-new (file+head "docs/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
                 ("o" "Output" plain
				  "%?"
				  :if-new (file+head "out/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
				 ("r" "Reference" plain
				  "%?"
				  :if-new (file+head "references/%<%Y%m%d>.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :reference:\n"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
				 ("c" "Capture" plain
				  "%?"
				  :if-new (file+head "%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :capture:\n"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
				 ))
   )
  :config
  (org-roam-db-autosync-mode)
  (org-roam-db-autosync-enable)
  )

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

(setq org-roam-node-display-template
      (concat "${type:10} - ${tags:30}: ${title:*}"))

(use-package org-roam-ui
  :after org-roam
  :custom
  ((org-roam-ui-sync-theme t)
   (org-roam-ui-follow t)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))

(use-package org-roam-timestamps
  :config
  (setq org-roam-timestamps-remember-timestamps t)
  (setq org-roam-timestamps-minimum-gap 3600)
  )

(setenv
 "DICPATH"
 "/home/jeykey/.tools/dict/")

(setq ispell-program-name "hunspell"
      ispell-local-dictionary "en_US"
      ispell-local-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
        ("de_DE" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE" "-a" "-i" "UTF-8") nil utf-8)))

(use-package langtool
  :init
  (setq langtool-http-server-host "172.16.96.3"
	langtool-http-server-port 8010)
  )

(use-package langtool-ignore-fonts
  :config
  (add-hook 'LaTeX-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'org-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'markdown-mode-hook 'langtool-ignore-fonts-minor-mode)
  (langtool-ignore-fonts-add 'markdown-mode '(markdown-code-face))
  )

(provide 'jk-org)
