;; Bibtex

(setq bibtex-dialect 'biblatex)

(setq bib-files-directory (directory-files
                           (concat (getenv "HOME") "/org/database/references/") t
                           "^[A-Z|a-z].+.bib$")
      pdf-files-directory (concat (getenv "HOME") "/files/references/"))

(use-package org-ref)

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

(use-package org-roam-bibtex)

(provide 'jk-bibtex)
