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
      org-export-with-sub-superscripts '{}
      org-export-allow-bind-keywords t
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

(use-package! org-fragtog
  ;; :disabled nil
  :after org
  :hook (org-mode . org-fragtog-mode)
  )

(use-package! org-download
  :init
  (setq
   org-download-image-dir "~/files/screenshots/"
   org-download-method 'directory
   org-download-heading-lvl 3
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
  :config
  (setq
   anki-editor-org-tags-as-anki-tags nil
   anki-editor-ignored-org-tags '()
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
  (setq org-roam-node-display-template
        (concat "${type:10} - ${tags:30}: ${title:*}"))
  (org-roam-db-autosync-mode)
  (org-roam-db-autosync-enable)
  (require 'org-roam-dailies)
  (require 'org-roam-export)
  )

(setq org-id-link-to-org-use-id 'create-if-interactive)

(setq org-roam-capture-templates '(
                                   ;; 'Literature' notes
                                   ("s" "Store" plain
                                    "%?"
                                    :if-new (file+head "store/%<%Y%m%d>-${slug}.org"
                                                       "#+TITLE: ${title}\n#+FILETAGS: :store:\n#+DATE: %<%Y-%m-%d %a>\n\nSource: \n\n\n* Anki :noexport:\n** _\n"
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


(use-package! good-scroll
  :config
  (good-scroll-mode 1)
  )

(use-package! pdf-tools
  :config
  (pdf-tools-install)
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; use normal isearch
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  ;; turn off cua so copy works
  (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
  ;; more fine-grained zooming
  (setq pdf-view-resize-factor 1.1)
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

(setq org-export-with-broken-links 'mark)
(setcdr (assoc "\\.pdf\\'" org-file-apps) "xdg-open %s")

;; (plist-put org-latex-preview-appearance-options :scale 42.0)

;; (setq org-latex-pdf-process
;;   '("lualatex -shell-escape -interaction nonstopmode %f"
;;     "lualatex -shell-escape -interaction nonstopmode %f"))

;; (setq org-latex-compiler "lualatex")

(setq org-latex-compiler "lualatex")
(setq org-latex-precompile nil)
(setq org-latex-preview-process-precompiled nil)

;; (setq org-latex-preview-process-default 'imagemagick)
(setq org-preview-latex-default-process 'imagemagick)
;; (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)
(setq org-latex-preview-numbered t)
; (setq org-latex-preview-live t)
; (setq org-latex-preview-live-debounce 0.25)

;; (use-package! org-latex-preview
;;   :config
;;   (plist-put org-latex-preview-appearance-options
;;              :page-width 0.8)
;;   (plist-put org-format-latex-options :scale 2)
;;   (plist-put org-format-latex-options :zoom 1.5)
;;   (setq org-latex-preview-process-default 'dvisvgm)
;;   (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)
;;   (setq org-latex-preview-numbered t)
;;   (setq org-latex-preview-live t)
;;   (setq org-latex-preview-live-debounce 0.25)
;;   (defun my/org-latex-preview-uncenter (ov)
;;     (overlay-put ov 'before-string nil))
;;   (defun my/org-latex-preview-recenter (ov)
;;     (overlay-put ov 'before-string (overlay-get ov 'justify)))
;;   (defun my/org-latex-preview-center (ov)
;;     (save-excursion
;;       (goto-char (overlay-start ov))
;;       (when-let* ((elem (org-element-context))
;;                   ((or (eq (org-element-type elem) 'latex-environment)
;;                        (string-match-p "^\\\\\\[" (org-element-property :value elem))))
;;                   (img (overlay-get ov 'display))
;;                   (prop `(space :align-to (- center (0.55 . ,img))))
;;                   (justify (propertize " " 'display prop 'face 'default)))
;;         (overlay-put ov 'justify justify)
;;         (overlay-put ov 'before-string (overlay-get ov 'justify)))))
;;   (define-minor-mode org-latex-preview-center-mode
;;     "Center equations previewed with `org-latex-preview'."
;;     :global nil
;;     (if org-latex-preview-center-mode
;;         (progn
;;           (add-hook 'org-latex-preview-overlay-open-functions
;;                     #'my/org-latex-preview-uncenter nil :local)
;;           (add-hook 'org-latex-preview-overlay-close-functions
;;                     #'my/org-latex-preview-recenter nil :local)
;;           (add-hook 'org-latex-preview-overlay-update-functions
;;                     #'my/org-latex-preview-center nil :local))
;;       (remove-hook 'org-latex-preview-overlay-close-functions
;;                     #'my/org-latex-preview-recenter)
;;       (remove-hook 'org-latex-preview-overlay-update-functions
;;                     #'my/org-latex-preview-center)
;;       (remove-hook 'org-latex-preview-overlay-open-functions
;;                     #'my/org-latex-preview-uncenter)))
;;   )

;; (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)

;; \\bibliography{~/Documents/refs.bib}
;; \\usepackage{subfiles,comment,units,subfig,fontawesome,graphicx,verbatim,nicefrac,ifthen,booktabs}
;; \\usepackage{fontsetup}

(defvar org-export-output-directory-prefix "exports/"
  "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(setq org-latex-classes
'(("article"
"\\RequirePackage{fix-cm}
\\PassOptionsToPackage{svgnames}{xcolor}
\\documentclass[11pt]{article}
\\usepackage[T1]{fontenc}
\\usepackage{amsmath,amscd,amssymb}
\\usepackage{unicode-math}
\\usepackage{pdfpages}
\\usepackage[english, german]{babel}
\\usepackage{enumitem}
\\usepackage{titling}
\\usepackage[
 a4paper,
 left=25mm,
 right=25mm,
 top=25mm,
 bottom=25mm
]{geometry}
\\usepackage{parskip}
\\makeatletter
\\renewcommand{\\maketitle}{%
  \\begingroup\\parindent0pt
  \\sffamily
  \\Huge{\\bfseries\\@title}\\par\\bigskip
  \\LARGE{\\bfseries\\@author}\\par\\medskip
  \\normalsize\\@date\\par\\bigskip
  \\endgroup\\@afterindentfalse\\@afterheading}
\\makeatother
%% Math
\\usepackage{subfiles,comment,units,subfig,fontawesome,verbatim,nicefrac,ifthen,booktabs}
\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\fancyhead{}
\\fancyfoot{}
\\fancyhead[R]{\\thepage}
\\fancyhead[L]{\\textit{\\thedate}}
\\fancyhead[C]{\\thetitle}
\\input{~/.latex/setup.tex}
\\thispagestyle{empty}
[DEFAULT-PACKAGES]
\\hypersetup{linkcolor=violet,urlcolor=violet,
             citecolor=DarkRed,colorlinks=true, filecolor=magenta}
\\AtBeginDocument{\\renewcommand{\\UrlFont}{\\ttfamily}}
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

("report" "\\documentclass[11pt]{report}"
("\\part{%s}" . "\\part*{%s}")
("\\chapter{%s}" . "\\chapter*{%s}")
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

("book" "\\documentclass[11pt]{book}"
("\\part{%s}" . "\\part*{%s}")
("\\chapter{%s}" . "\\chapter*{%s}")
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
