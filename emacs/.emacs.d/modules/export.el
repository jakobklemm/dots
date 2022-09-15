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

(require 'org)

;; (setq org-latex-pdf-process '("texi2dvi -p -b -V %f"))
;; (setq org-latex-to-pdf-process '("xelatex %f && bibtex %f && xelatex %f && xelatex %f"))
;; (setq org-latex-to-pdf-process (list "latexmk -pdf -bibtex %f"))
(setq org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(setq org-src-fontify-natively t)

;; Open directly PDFs in browser.
(setcdr (assoc "\\.pdf\\'" org-file-apps) "brave %s")

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
