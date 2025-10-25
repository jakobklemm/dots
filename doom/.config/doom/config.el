;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; (load-theme 'modus-operandi)

(setq user-full-name "Jakob Klemm"
      user-mail-address "github@jeykey.net"
      doom-font "MonaspiceAr Nerd Font Mono"
      ;; doom-theme 'doom-rose-pine-moon
      ;; catppuccin-flavor 'frappe
      ;; catppuccin-flavor 'frappe
      ;; doom-theme 'catppuccin
      ;; doom-theme 'doom-henna
      doom-theme 'doom-rose-pine-dawn
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
      org-todo-keywords '((sequence "TODO(t)" "BLOCKED(b)" "GEN(g)"
               "|"
               "DONE(d/!)" "SEP(s@/!)"))
      )

(display-time-mode 1)
(global-subword-mode 1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Hide line numbers in zen-mode
(add-hook 'writeroom-mode-hook
          (lambda ()
            (if writeroom-mode
                (display-line-numbers-mode -1)
              (display-line-numbers-mode 1))))

(setq org-id-locations-file "~/.org-id-locations")

(add-hook 'org-capture-mode-hook 'evil-insert-state)
(setq org-capture-templates
      `(
            ("j" "Journal" plain (function buffer-file-name)
             "*** %<%Y-%m-%d> %?"
             :empty-lines 1
             )
        )
      )

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
  :init
  (setq jinx-languages "en_US de_CH")
  :config
  (add-hook 'text-mode-hook #'jinx-mode)
  (add-hook 'conf-mode-hook #'jinx-mode)
  (add-hook 'prog-mode-hook #'jinx-mode)

  (map! :leader
        :prefix "s"
        :desc "Correct word at point" "c" #'jinx-correct
        :desc "Correct nearest" "n" #'jinx-correct-nearest
        :desc "Show corrections" "s" #'jinx-correct-all
        )
  )

(use-package! svg-tag-mode
  :config
  (set-face-attribute 'svg-tag-default-face nil :family "CommitMono Nerd Font Bold")
  :hook (org-mode . svg-tag-mode)
  )

;; https://howardabrams.com/hamacs/ha-org-word-processor.html
(defface org-checkbox-done-text
  '((t (:foreground "#71696A" :strike-through t)))
  "Face for the text part of a checked org-mode checkbox.")

(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
    1 'org-checkbox-done-text prepend))
 'append)

(use-package! org-download
  :init
  (setq
   org-download-image-dir "~/files/database/auto/"
   org-download-method 'directory
   org-download-heading-lvl 0
   org-download-abbreviate-filename-function 'concat
   org-download-screenshot-method "gnome-screenshot -a -f %s"
   ;; org-download-screenshot-method "flameshot gui -p %s"
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
  (setq
   anki-editor-org-tags-as-anki-tags nil
   anki-editor-ignored-org-tags '("noexport")
   )
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

(plist-put org-format-latex-options :scale 1.3)
(plist-put org-format-latex-options :zoom 1.3)

(with-eval-after-load 'org
  (setq org-preview-latex-default-process 'dvisvgm)
  (setf (plist-get (cdr (assq 'dvisvgm org-preview-latex-process-alist)) :latex-compiler)
        '("dvilualatex -interaction nonstopmode -output-directory %o %f"))

  ;; Enable persistent preview caching in home directory
  (setq org-preview-latex-image-directory "~/.ltximg/")
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
[DEFAULT-PACKAGES]
[PACKAGES]
\\setlength{\\parindent}{0pt}
\\setlength{\\parskip}{0pt}
\\pagestyle{empty}
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
("\\subparagraph{%s}" . "\\subparagraph*{%s}")
)
)
)

(use-package! engrave-faces
  :init
  (setq org-latex-src-block-backend 'engraved))
