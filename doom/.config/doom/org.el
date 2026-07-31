(setq org-id-locations-file "~/.org-id-locations")

 	
(setq org-fontify-quote-and-verse-blocks t)

(after! org
        (setq org-startup-indented t  ; Clean indentation
                org-adapt-indentation nil  ; Don't indent content
                org-startup-folded 'content  ; Start with content folded
                org-cycle-separator-lines 2  ; More breathing room
                org-fontify-whole-heading-line t  ; Better heading visibility
                org-fontify-done-headline t  ; Highlight done items
                org-fontify-quote-and-verse-blocks t  ; Better block styling
                org-pretty-entities nil  ; Disable entity prettification (conflicts with fragtog)
                org-pretty-entities-include-sub-superscripts nil  ; Disable sub/superscript prettification
                org-use-sub-superscripts '{})  ; Only recognize sub/superscripts with braces

(setq org-highlight-latex-and-related nil)) 

(custom-set-faces!
        '(outline-1 :weight extra-bold :height 1.25)
        '(outline-2 :weight bold :height 1.15)
        '(outline-3 :weight bold :height 1.12)
        '(outline-4 :weight semi-bold :height 1.09)
        '(outline-5 :weight semi-bold :height 1.06)
        '(outline-6 :weight semi-bold :height 1.03)
        '(outline-8 :weight semi-bold)
        '(outline-9 :weight semi-bold))

(custom-set-faces!
        '(org-document-title :height 1.2))

(setq org-fontify-quote-and-verse-blocks t)


(use-package! org-modern
        :hook (org-mode . org-modern-mode)
        :config
        (setq org-modern-label-border nil
        org-modern-star '("◉" "○" "◈" "◇" "✳" "◆" "✦" "▶")
        org-modern-hide-stars t  ; Clean up leading stars
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                                (45 . "–")
                                (42 . "•"))
        org-modern-footnote (cons nil (cadr org-script-display))
        org-modern-block-fringe nil
        org-modern-block-name
        '((t . t)
                ("src" "»" "«")
                ("example" "»–" "–«")
                ("quote" "❝" "❞")
                ("export" "⏩" "⏪"))
        org-modern-progress nil
        org-modern-priority nil
        org-modern-horizontal-rule (make-string 36 ?─)
        org-modern-todo t  ; Modern TODO styling
        org-modern-tag nil  ; Cleaner tags
        org-modern-timestamp t  ; Modern timestamps
        org-modern-statistics t  ; Modern statistics cookies
        org-modern-checkbox '((?X . "☑")
                                (?- . "◫")
                                (?\s . "☐"))))

(use-package org-appear
        :init
        (setq
        org-hide-emphasis-markers t
        org-appear-autoemphasis t
        org-appear-autolinks t
        org-appear-autosubmarkers t
        org-appear-autoentities nil
        org-appear-autokeywords t
        )
        :config
        (add-hook 'org-mode-hook 'org-appear-mode)
        )

(use-package! org-download
	  :init
	  (setq
	   org-download-image-dir "~/files/database/auto/"
	   org-download-method 'directory
	   org-download-heading-lvl 0
	   org-download-abbreviate-filename-function 'concat
	   ;; org-download-screenshot-method "gnome-screenshot -a -f %s"
	   org-download-screenshot-method "flameshot gui -p %s"
	   ;; org-download-screenshot-method "~/.local/bin/flameshot-wayland %s"
	   org-download-timestamp "%Y-%m-%d_%H-%M-%S_"
	   org-download-display-inline-images t
	   )
	  :config
	  (map! :leader
	        :prefix "m"
	        "s" #'org-download-screenshot
	        )
	  )
	
(use-package! anki-editor
        :config
        (setq anki-editor-org-tags-as-anki-tags nil
              anki-editor-ignored-org-tags '("noexport")))


(use-package! org-roam
        :init
        (map! :leader
        :prefix "n"
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-buffer-toggle" "t" #'org-roam-buffer-toggle
        :desc "org-roam-dailies-today" "d" #'org-roam-dailies-goto-today
        :desc "org-roam-dailies-capture" "e" #'org-roam-dailies-capture-today
        :desc "org-roam-refile" "r" #'org-roam-refile
        :desc "add an alias" "a" #'org-roam-alias-add
        :desc "sources => refs" "s" #'org-roam-ref-add
        :desc "refs search" "j" #'org-roam-ref-add
        :desc "refs delete" "k" #'org-roam-ref-add
        )
        :custom
        (
                (org-roam-db-location "~/Documents/org-roam.db")
                (org-roam-directory "~/org/")
                (org-roam-dailies-directory "daily/")
                (org-roam-v2-ack t)
                (org-roam-completion-everywhere t)
                (org-roam-db-index-interval 3600) 
                (org-roam-db-cache-dir "~/.cache/org-roam/")
        )
        :config
        (cl-defmethod org-roam-node-type ((node org-roam-node))
                "Return the TYPE of NODE."
                (condition-case nil
                        (file-name-nondirectory
                                (directory-file-name
                                (file-name-directory
                                (file-relative-name (org-roam-node-file node) org-roam-directory))))
                        (error "")))

        (cl-defmethod org-roam-node-timestamp ((node org-roam-node))
                "Return the time."
                (org-roam-timestamps-decode (org-roam-node-file-mtime node)))

        (setq org-roam-node-display-template
        (concat "${file-title:30} - ${timestamp} - ${type:10} - ${tags:20} - ${aliases:20}: ${title:*}"))
        (org-roam-db-autosync-mode)
        (require 'org-roam-dailies)
        ;; (require 'org-cite)
        (require 'org-roam-export)
        (setq org-roam-tag-all-matches-everywhere t)
        (setq org-roam-tag-sort 'freq)

        (setq org-roam-node-display-template
        (concat "${file-title:40} | ${tags:15} | ${timestamp} | ${type:10}"))

        (when (fboundp 'org-roam-server-mode)
        (org-roam-server-mode 1))

        (when (fboundp 'org-roam-protocol-mode)
        (org-roam-protocol-mode 1))
        )


(use-package! org-ref
        :config
        (setq bibtex-completion-bibliography '(
                                                "~/files/biblio/refs.bib"
                                                "~/files/biblio/auto.bib"
                                                )))

(use-package! org-roam-bibtex
        :after org-roam
        :config
        (require 'org-ref))

(setq org-id-link-to-org-use-id 'create-if-interactive)

(setq org-roam-capture-templates '(
                                        ("s" "Store" plain
                                        "%?"
                                        :if-new (file+head "store/%<%Y%m%d>-${slug}.org"
                                                        "#+TITLE: ${title}
#+FILETAGS:
#+SETUPFILE: ~/.latex/store.org
#+OPTIONS:
#+DATE: %<%Y-%m-%d %a>

Source:

-----

* Anki :noexport:\n** _\n"
                                                        )
                                        :immediate-finish t
                                        :unnarrowed t

                                        )
                                        ("d" "Devel" plain
                                        "%?"
                                        :if-new (file+head "devel/%<%Y%m%d>-${slug}.org"
                                                        "#+TITLE: ${title}\n#+FILETAGS: :devel:\n#+DATE: %<%Y-%m-%d %a>\n\nSource: \n\n* Local Variables :noexport: \n# Local Variables:\n# jinx-languages: \"de_CH\"\n# End:\n"
                                                        )
                                        :immediate-finish t
                                        :unnarrowed t
                                        )
                                        ;; Index
                                        ("i" "Index" plain
                                        "%?"
                                        :if-new (file+head "index/${slug}.org"
                                                        "#+TITLE: ${title}\n#+FILETAGS: :index:\n#+DATE: %<%Y-%m-%d %a>\n"
                                                        )
                                        :immediate-finish t
                                        :unnarrowed t
                                        )
                                        ("l" "Link" plain
                                        "%?"
                                        :if-new (file+head "links/%<%Y%m%d>-${slug}.org"
                                                        "#+TITLE: ${title}\n#+FILETAGS: :link:\n#+DATE: %<%Y-%m-%d %a>\n"
                                                        )
                                        :immediate-finish t
                                        :unnarrowed t
                                        )
                                        )
        )

(setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%I:%M %p>: %?"
                :if-new (file+head "%<%Y-%m-%d>.org" "#+TITLE: %<%Y-%m-%d>\n"))))

(use-package! org-roam-ui
        :after org-roam
        :custom
        ((org-roam-ui-sync-theme t)
        (org-roam-ui-follow nil)
        (org-roam-ui-update-on-save t)
        (org-roam-ui-open-on-start nil)
        ))

(use-package! org-roam-timestamps
        :config
        (setq org-roam-timestamps-remember-timestamps t)
        (setq org-roam-timestamps-minimum-gap 3600)
        (org-roam-timestamps-mode t)
        )

(setq org-export-with-broken-links 'mark)
(setcdr (assoc "\\.pdf\\'" org-file-apps) "xdg-open %s")

;; Generate all previews in buffer:
;; "SPC-u SPC-u C-c C-x C-l"

(with-eval-after-load 'ox-latex
        (setq org-latex-compiler "lualatex"
                org-latex-pdf-process (list "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode -synctex=1' -outdir=exports/ -bibtex -pdf -f %f")))

;; (with-eval-after-load 'ox-latex
;;     (setq org-latex-compiler "lualatex"
;;           org-latex-pdf-process (list "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode -synctex=1' -bibtex -pdf -f %f")))


(setq org-latex-precompile nil)

(plist-put org-format-latex-options :scale 1.3)
(plist-put org-format-latex-options :zoom 1.3)

(with-eval-after-load 'org
        (setq org-preview-latex-default-process 'dvisvgm)
        (setf (plist-get (cdr (assq 'dvisvgm org-preview-latex-process-alist)) :latex-compiler)
        '("dvilualatex -interaction nonstopmode -output-directory %o %f"))

        ;; Enable persistent preview caching in home directory
        (setq org-preview-latex-image-directory "~/files/latex/")
        (plist-put org-format-latex-options :background "Transparent"))

(defvar org-export-output-directory-prefix "exports/"
        "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
        "Modifies org-export to place exported files in a different directory"
        (when (not pub-dir)
        (setq pub-dir org-export-output-directory-prefix)
        (when (not (file-directory-p pub-dir))
        (make-directory pub-dir))))

(setq org-format-latex-header
        "\\documentclass{article}
\\usepackage[margin=0pt]{geometry}
\\input{~/.latex/preview.tex}
\\providecommand{\\covernum}[1]{}
\\providecommand{\\covertitle}[1]{}
\\providecommand{\\coverauthor}[1]{}
\\providecommand{\\coversupervisedby}[1]{}
\\providecommand{\\coverdate}[1]{}
[DEFAULT-PACKAGES]
[PACKAGES]
\\setlength{\\parindent}{0pt}
\\setlength{\\parskip}{0pt}
\\pagestyle{empty}
")

(with-eval-after-load 'ox-latex
        (add-to-list 'org-latex-packages-alist '("" "svg" t))
        (setq org-latex-packages-alist
        (append org-latex-packages-alist '(("inkscapelatex=false" "svg" t)))))

(setq org-latex-default-packages-alist nil)

(setq org-latex-preview-preamble
        "\\documentclass{article}
\\usepackage{luacolor}
\\input{~/.latex/preview.tex}
\\providecommand{\\covernum}[1]{}
\\providecommand{\\covertitle}[1]{}
\\providecommand{\\coverauthor}[1]{}
\\providecommand{\\coversupervisedby}[1]{}
\\providecommand{\\coverdate}[1]{}
[DEFAULT-PACKAGES]
[PACKAGES]")

(setq org-latex-engraved-preamble "\\usepackage{fvextra}

[FVEXTRA-SETUP]

% Make line numbers smaller and grey.
\\renewcommand\\theFancyVerbLine{\\footnotesize\\color{black!40!white}\\arabic{FancyVerbLine}}

% In case engrave-faces-latex-gen-preamble has not been run.
\\providecolor{EfD}{HTML}{f7f7f7}\n\\providecolor{EFD}{HTML}{28292e}

% Define a Code environment to prettily wrap the fontified code.
\\providecommand{\\codefont}{\\footnotesize}
\\DeclareTColorBox[]{Code}{o}%
{colback=EfD!98!EFD, colframe=EfD!95!EFD,
        fontupper=\\setlength{\\fboxsep}{0pt}\\codefont,
        colupper=EFD,\n  IfNoValueTF={#1}%
        {boxsep=2pt, arc=2.5pt, outer arc=2.5pt,
        boxrule=0.5pt, left=2pt}%
        {boxsep=2.5pt, arc=0pt, outer arc=0pt,
        boxrule=0pt, leftrule=1.5pt, left=0.5pt},
        right=2pt, top=1pt, bottom=0.5pt,
        breakable}

[LISTINGS-SETUP]")

(add-to-list 'org-export-filter-timestamp-functions
                #'endless/filter-timestamp)
(defun endless/filter-timestamp (trans back _comm)
        "Remove <> around time-stamps."
        (pcase back
        ((or `jekyll `html)
        (replace-regexp-in-string "&[lg]t;" "" trans))
        (`latex
        (replace-regexp-in-string "[<>]" "" trans))))

(setq-default org-display-custom-times t)
;;; Before you ask: No, removing the <> here doesn't work.
(setq org-time-stamp-custom-formats
        '("<%d %b %Y>" . "<%d/%m/%y %a %H:%M>"))

(use-package! org-fragtog
        :after org
        :config
        (add-hook 'org-mode-hook 'org-fragtog-mode)
        (add-hook 'org-mode-hook
                (lambda ()
                (org-latex-preview '(16))))

        (defun jk/org-generate-all-previews (directory)
        "Generate LaTeX previews for all org files in DIRECTORY recursively."
        (interactive "DGenerate previews for org files in directory: ")
        (let* ((org-files (directory-files-recursively directory "\\.org$"))
                (total (length org-files))
                (current 0)
                (successful 0)
                (failed 0))
        (if (= total 0)
                (message "No org files found in %s" directory)
        (message "Found %d org files. Starting preview generation..." total)
        (dolist (file org-files)
                (setq current (1+ current))
                (message "[%d/%d] Processing: %s" current total (file-name-nondirectory file))
                (condition-case err
                (progn
                (with-current-buffer (find-file-noselect file)
                        (org-latex-preview '(16))
                        (kill-buffer))
                (setq successful (1+ successful))
                (message "[%d/%d] ✓ Done: %s" current total (file-name-nondirectory file)))
                (error
                (setq failed (1+ failed))
                (message "[%d/%d] ✗ Failed: %s - %s" current total (file-name-nondirectory file) err))))
        (message "\n=== Summary ===\nSuccessfully processed: %d\nFailed: %d\nTotal: %d"
                        successful failed total))))

        (map! :leader
        :prefix "m"
        :desc "Generate LaTeX previews for directory" "p" #'my/org-generate-all-previews)
        )

(setq org-latex-classes
'(("article"
        "[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]
\\input{~/.latex/export.tex}
[EXTRA]"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
        ("\\paragraph{%s}" . "\\paragraph*{%s}")
        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(add-to-list 'org-latex-classes
        '("systems-thesis"
        "[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]
\\documentclass{report}
\\usepackage[a4paper, total={6in, 8in}]{geometry}
\\usepackage{graphicx}
\\usepackage{parskip}
\\usepackage[luatex]{xcolor}
\\usepackage{colortbl}
\\usepackage{array}
\\usepackage{hyperref}
\\usepackage{listings}
\\usepackage[numbers]{natbib}
\\usepackage{luacolor}
\\usepackage{minted}
\\usepackage[minted]{tcolorbox}
\\usepackage{caption}
\\usepackage{newfloat}
\\usepackage{pdfpages}
\\usepackage[inkscapelatex=false]{svg}
\\usepackage[bachelorthesis]{systems-cover}
\\tcbuselibrary{minted,skins,breakable}
\\definecolor{backgroundColor}{gray}{0.85}
\\definecolor{TblHeader}{HTML}{2C3E50}
\\definecolor{TblAlt}{HTML}{EBF5FB}
\\definecolor{TblBorder}{HTML}{85929E}
\\arrayrulecolor{TblBorder}
\\setlength{\\arrayrulewidth}{0.5pt}
\\renewcommand{\\arraystretch}{1.35}
\\newtcbox{\\mintedinline}[1][]{on line,colback=backgroundColor,colframe=backgroundColor,boxrule=0pt,arc=3pt,left=2pt,right=2pt,top=2.5pt,bottom=2.5pt,boxsep=0pt}
[EXTRA]"
        ("\\chapter{%s}"       . "\\chapter*{%s}")
        ("\\section{%s}"       . "\\section*{%s}")
        ("\\subsection{%s}"    . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

(with-eval-after-load 'ox-latex
        (setq org-latex-src-block-backend 'minted)

        (setq org-latex-minted-options
        '(("fontsize"    "\\small")
                ("breaklines"  "true")
                ("linenos"     "true")
                ("numbersep"   "8pt")
                ("xleftmargin" "8pt")))

        (advice-remove 'org-latex-src-block #'jk/wrap-src-block-tcolorbox)

        (defun jk/wrap-src-block-tcolorbox (orig-fn src-block contents info)
        (format "\\begin{center}
\\begin{tcolorbox}[enhanced,colback=blue!3,colframe=black,boxrule=0.5pt,boxsep=0pt,left=4pt,right=4pt,top=2pt,bottom=2pt]
%s
\\end{tcolorbox}
\\end{center}"
                (funcall orig-fn src-block contents info)))

        (advice-add 'org-latex-src-block :around #'jk/wrap-src-block-tcolorbox))

(use-package! engrave-faces
        :init
        (setq org-latex-src-block-backend 'engraved))

(setq org-latex-caption-above nil)
