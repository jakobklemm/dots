;; Org Export settings

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
(setcdr (assoc "\\.pdf\\'" org-file-apps) "brave %s")

(defvar org-export-output-directory-prefix "exports/"
  "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(provide 'jk-ox)
