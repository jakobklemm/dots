;; Export

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

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

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

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

(setq org-src-fontify-natively t)

;; Open directly PDFs in browser.
(setcdr (assoc "\\.pdf\\'" org-file-apps) "firefox %s")

(defvar org-export-output-directory-prefix ".export/"
  "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(require 'org)

(setq org-src-fontify-natively t)

(add-to-list 'org-latex-classes
             '("structured"
               "\\documentclass[a4paper,11pt,titlepage,oneside]{memoir}
\\usepackage[utf8]{inputenc}
\\usepackage[]{babel}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("linalg"
               "\\documentclass[11pt]{article}
\\input{~/.latex/linalg_header.tex}
\\usepackage[utf8]{inputenc}
\\usepackage[]{babel}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
"))

(defun jk/title-title ()
  (car (org-roam--extract-titles-title))
  )
(defun jk/title-author ()
  (cdr (car (org-roam--extract-global-props '("AUTHOR"))))
  )
(defun jk/title-image ()
  (cdr (car (org-roam--extract-global-props '("IMAGE"))))
  )
(defun jk/title-subtitle ()
  (cdr (car (org-roam--extract-global-props '("SUBTITLE"))))
  )

(defun jk/title-compose ()
  (interactive)
  (insert (concat "
   #+LATEX_HEADER: \\usepackage[utf8]{inputenc}
   #+LATEX_HEADER: \\usepackage[dvipsnames]{xcolor}
   #+LATEX_HEADER: \\usepackage{tikz}
   #+LATEX_HEADER: \\usepackage[]{babel}
   \\begin{titlepage}
	 \\begin{center}
	     \\begin{tikzpicture}[remember picture,overlay]
		 \\node[anchor=north west,yshift=-1.5pt,xshift=1pt]%
		 at (current page.north west)
		 {\\includegraphics[scale=1]{~/.tools/"
		       "IMAGE"
		       ".png}};
   \\end{tikzpicture}
	     \\vspace{2.2cm}
	     \\Huge
	     \\textbf{"
		       "TITILE"
		       "}
	     \\vspace{3.0cm}
	     \\LARGE"
		       "SUBTITLE"
		       "
   \\vspace{4.2cm}"

		       "AUTHOR"

	     "\\
	     \\vfill
	     \\Large
	     Baden, Schweiz\\
	     \\today
	 \\end{center}
   \\end{titlepage}
   \\tableofcontents
   \\newpage"
		)
	       )
     )

(provide 'export)
