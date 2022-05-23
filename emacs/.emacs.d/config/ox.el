(eval-after-load "org" '(require 'ox-odt nil t))

(use-package htmlize
  :defer t)

(use-package ox-pandoc
  :defer t
  )

(use-package ox-hugo
  :defer t
  :config
  (setq org-hugo-auto-set-lastmod t)
  )

(use-package ox-reveal
  :defer t
  :custom ((org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
           (org-reveal-mathjax t)
           (org-reveal-ignore-speaker-notes nil)
           (org-reveal-note-key-char nil)))

(use-package ox-gemini
  )

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(require 'org)
(setq org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(setq org-src-fontify-natively t)

;; Open directly PDFs in browser.
(setcdr (assoc "\\.pdf\\'" org-file-apps) "brave %s")

(require 'ox-publish)
