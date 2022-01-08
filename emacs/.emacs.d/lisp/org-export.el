(setq-default org-startup-with-latex-preview t)

(setq TeX-parse-self t)
(setq TeX-auto-save t)

(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (setq TeX-master t)))

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

(use-package plantuml-mode
  :defer t
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  )

(use-package ox-reveal
  :defer t
  :custom ((org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
           (org-reveal-mathjax t)
           (org-reveal-ignore-speaker-notes nil)
           (org-reveal-note-key-char nil)))

(use-package ob-elixir
  :defer t
  )

(use-package ob-rust
  :defer t
  )

(use-package ob-go
  :defer t
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (elixir . t)
   (latex . t)
   (rust . t)
   ))

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

(use-package htmlize
  :defer t
  )
