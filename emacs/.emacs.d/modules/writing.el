;; Writing

(setenv
 "DICPATH"
 "/home/jeykey/.tools/dict/")

(use-package org
  :hook
  (org-mode . org-toggle-inline-images)
  (org-mode . org-indent-mode)
  (text-mode . flyspell-mode)
  (org-mode . flyspell-mode)
  :custom
  ((org-directory "~/documents/")
   (org-agenda-files '("~/supervisor/"))
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
   (ispell-program-name "hunspell")
   (ispell-local-dictionary "en_US")
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
  )

(use-package langtool
  :init
  (setq langtool-http-server-host "172.16.3.15"
	langtool-http-server-port 8010)
  )

(use-package langtool-ignore-fonts
  :config
  (add-hook 'LaTeX-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'org-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'markdown-mode-hook 'langtool-ignore-fonts-minor-mode)
  (langtool-ignore-fonts-add 'markdown-mode '(markdown-code-face))
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

(setq bibtex-dialect 'biblatex)

(setq bib-files-directory (directory-files
                           (concat (getenv "HOME") "/org/database/references/") t
                           "^[A-Z|a-z].+.bib$")
      pdf-files-directory (concat (getenv "HOME") "/files/references/"))

(use-package helm-bibtex
    :config
    (setq bibtex-completion-bibliography bib-files-directory
          bibtex-completion-library-path pdf-files-directory
          bibtex-completion-pdf-field "File"
          bibtex-completion-notes-path org-directory
          bibtex-completion-additional-search-fields '(keywords))
  )

(use-package citar
  :bind (("C-c b" . citar-insert-citation)
         :map minibuffer-local-map
         ("M-b" . citar-insert-preset))
  :custom
  (citar-bibliography '("~/org/database/references/references.bib")))

(setq citar-symbols
      `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
        (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
        (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
(setq citar-symbol-separator "  ")

(setq org-ref-default-citation-link "citep")

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(use-package org-roam-bibtex)

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

;; (setq org-latex-pdf-process
;;       '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(setq org-src-fontify-natively t)

;; Open directly PDFs in browser.
(setcdr (assoc "\\.pdf\\'" org-file-apps) "firefox %s")

(provide 'writing)
