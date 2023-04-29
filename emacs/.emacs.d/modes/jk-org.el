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
(require 'org-mouse)

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

(use-package org-transclusion)

(setq-default org-startup-with-latex-preview t)

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :config
  (plist-put org-format-latex-options :scale 1.6)
  :custom
  ((org-latex-preview-ltxpng-directory "~/.ltxpng/")))

(use-package ob-rust)
(use-package ob-go)
(use-package ob-elixir)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (latex . t)
   (rust . t)
   (go . t)
   (elixir . t)
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

(use-package org-ref)


(eval-after-load "org" '(require 'ox-odt nil t))

(use-package htmlize)

(use-package ox-pandoc
  )

(use-package ox-hugo
  :config
  (setq org-hugo-auto-set-lastmod t)
  )

(use-package plantuml-mode
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  )

(use-package ox-reveal
  :custom ((org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
           (org-reveal-mathjax t)
           (org-reveal-ignore-speaker-notes nil)
           (org-reveal-note-key-char nil)))

(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
       "bibtex %b"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))

(setq org-src-fontify-natively t)
(setq org-latex-listings t)

;; Open exports in browser
(setcdr (assoc "\\.pdf\\'" org-file-apps) "firefox %s")

(defvar org-export-output-directory-prefix "exports/"
  "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(provide 'jk-org)
