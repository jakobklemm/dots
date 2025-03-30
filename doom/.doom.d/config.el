;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jakob Klemm"
      user-mail-address "github@jeykey.net"
      doom-font "MonaspiceAr Nerd Font Mono"
      doom-theme 'doom-henna
      display-line-numbers-type t
      display-line-numbers-type 'relative
      org-directory "~/org/"
      delete-by-moving-to-trash t
      window-combination-resize t
      x-stretch-cursor t
      undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      truncate-string-ellipsis "…"
      password-cache-expiry nil
      scroll-margin 2
      display-time-default-load-average nil
      which-key-idld 0.5
      evil-vsplit-window-right t
      evil-split-window-below t
      prescient-history-length 1000
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t
      +zen-text-scale 1.2
      +zen-mixed-pitch-modes '()
      org-agenda-files (list org-directory)
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-fold-catch-invisible-edits 'smart
      org-image-actual-width '(0.9)
      org-ellipsis " ▾ "
      org-hide-leading-stars t
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue))
      scroll-preserve-screen-position 'always
      scroll-margin 12
      scroll-preserve-screen-position t
      doom-modeline-enable-word-count t
      )

(display-time-mode 1)
(global-subword-mode 1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq org-id-locations-file "~/.org-id-locations")

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-label-border nil)
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-footnote
        (cons nil (cadr org-script-display))
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
        )
  )

(use-package org-appear
  :init
  (setq
   org-hide-emphasis-markers t
   org-appear-autoemphasis t
   org-appear-autolinks t
   org-appear-autosubmarkers t
   org-appear-autoentities t
   org-appear-autokeywords t
   )
  :config
  (add-hook 'org-mode-hook 'org-appear-mode)
  )

(map!
 :leader
 "/" #'+default/search-buffer
 "SPC" #'+vertico/switch-workspace-buffer
 "r" #'consult-recent-file
 )

(map!
 :leader
 :prefix "f"
 "g" #'consult-ripgrep
 )

(use-package! jinx
  :config
  (map! :leader
        :prefix "m"
        "c" #'jinx-correct-nearest
        )
  (add-hook 'emacs-startup-hook #'global-jinx-mode)
  )

(use-package! svg-tag-mode
  :config
  (set-face-attribute 'svg-tag-default-face nil :family "CommitMono Nerd Font Bold")
  :hook (org-mode . svg-tag-mode)
  )

(use-package! org-download
  :init
  (setq
   org-download-image-dir "~/files/database/auto/"
   org-download-method 'directory
   org-download-heading-lvl 0
   org-download-abbreviate-filename-function 'concat
   org-download-screenshot-method "gnome-screenshot -a -f %s"
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
  ;; :config
  ;; (setq
  ;;  anki-editor-org-tags-as-anki-tags nil
  ;;  anki-editor-ignored-org-tags '("noexport")
  ;;  )
  )

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
    (org-roam-timestamps-decode (org-roam-node-file-mtime node))
    )

  (setq org-roam-node-display-template
        (concat "${file-title:30} - ${timestamp} - ${type:10} - ${tags:20} - ${aliases:20}: ${title:*}"))
  (org-roam-db-autosync-mode)
  (org-roam-db-autosync-enable)
  (require 'org-roam-dailies)
  ;; (require 'org-cite)
  ;; (require 'org-roam-export)
  )

(use-package! org-ref
  :config
  (setq bibtex-completion-bibliography '(
                                         "~/files/biblio/refs.bib"
                                         "~/files/biblio/auto.bib"
                                         ))
  )

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
                                   ("c" "Quick Capture" plain
                                    "%?"
                                    :if-new (file+head "quick/${slug}.org"
                                                       "#+TITLE: ${title}\n#+FILETAGS: :quick:\n#+DATE: %<%Y-%m-%d %a>\n"
                                                       )
                                    :immediate-finish t
                                    :unnarrowed t
                                    )
                                   ("l" "Link" plain
                                    "%?"
                                    :if-new (file+head "quick/${slug}.org"
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
   ;; (org-roam-ui-follow nil)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))

(use-package! org-roam-timestamps
  :config
  (setq org-roam-timestamps-remember-timestamps t)
  (setq org-roam-timestamps-minimum-gap 3600)
  (org-roam-timestamps-mode t)
  )

;; TODO: BAD
(org-roam-db-sync)

(use-package! good-scroll
  :config
  (good-scroll-mode 1)
  )

(use-package! org-incoming
  :custom (org-incoming-dirs '((:source "~/files/source/" :target "~/org/links/" :pdf-subdir "documents/" :use-roam 't :annotation-template "
#+TITLE: ${title}
#+DATE: ${date}
#+FILETAGS: :link:

Source:
File: [[${link}]]

* Content

${extracted}

"
                               )))
  )

;; TODO: Figure this out at some point
(use-package! org-special-block-extras
  :hook (org-mode . org-special-block-extras-mode)
  )

(setq org-export-with-broken-links 'mark)
(setcdr (assoc "\\.pdf\\'" org-file-apps) "xdg-open %s")

;; Generate all previews in buffer:
;; "SPC-u SPC-u C-c C-x C-l"

(with-eval-after-load 'ox-latex
    (setq org-latex-compiler "lualatex"
          org-latex-pdf-process (list "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode -synctex=1' -outdir=exports/ -bibtex -pdf -f %f")))

(setq org-latex-precompile nil)
(setq org-latex-preview-process-precompiled nil)

(plist-put org-format-latex-options :scale 1.25)
(plist-put org-format-latex-options :zoom 1.25)

(with-eval-after-load 'org
  (setq org-preview-latex-default-process 'dvisvgm)
  (setf (plist-get (cdr (assq 'dvisvgm org-preview-latex-process-alist)) :latex-compiler)
        '("dvilualatex -interaction nonstopmode -output-directory %o %f")))

(defvar org-export-output-directory-prefix "exports/"
  "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(setq org-latex-preview-preamble
      "\\documentclass{article}
\\input{~/.latex/preview.tex}
[DEFAULT-PACKAGES]
[PACKAGES]
"
      )

(setq org-latex-default-packages-alist nil)
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

(use-package! org-latex-preview
  :config
  (plist-put org-latex-preview-appearance-options
             :page-width 0.9)

  (setq org-latex-preview-process-default 'dvisvgm)
  (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)

  (setq org-latex-preview-auto-ignored-commands
        '(next-line previous-line mwheel-scroll
          scroll-up-command scroll-down-command))

  (setq org-latex-preview-numbered t)
  (setq org-latex-preview-live t)
  (setq org-latex-preview-live-debounce 0.25)
  )

(setq org-latex-classes
'(("article"
"\\input{~/.latex/export.tex}
[DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")
)
)
)

(use-package! engrave-faces
  :init
  (setq org-latex-src-block-backend 'engraved))
