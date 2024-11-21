;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Default settings (https://tecosaur.github.io/emacs-config/config.html#simple-settings)
(setq user-full-name "Jakob Klemm"
      user-mail-address "github@jeykey.net"
      doom-font "Monaspace Argon"
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
      )

(display-time-mode 1)
(global-subword-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-quick-access t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort))

(use-package! popper
  :bind (("C-,"   . popper-toggle)
         ("M-,"   . popper-cycle)
         ("C-M-," . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "^\\*Warnings\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*Shell Command Output\\*"
          help-mode
          "^\\*helpful .*\\*"
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1)
  )

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  ((org-hide-emphasis-markers t)
   (org-appear-autoemphasis t)
   (org-appear-autolinks t)
   (org-appear-autoentities t)
   (org-appear-autoentities t)
   (org-appear-trigger 'always)
   (org-appear-autosubmarkers t))
  )

(use-package! jinx
  :bind
  (
   ("M-p" . jinx-correct-word)
   ("C-n" . jinx-next)
   ("C-M-p" . jinx-languages)
   )
  :config
  (dolist (hook '(text-mode-hook prog-mode-hook conf-mode-hook))
    (add-hook hook #'jinx-mode))
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

(use-package! svg-tag-mode
  :config
  (set-face-attribute 'svg-tag-default-face nil :family "CommitMono Nerd Font Bold")
  :hook (org-mode . svg-tag-mode)
  )

(use-package! org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode)
  )

(after! org-download
  (setq
   org-download-image-dir "~/files/screenshots/"
   org-download-method 'directory
   org-download-heading-lvl 2
   org-download-abbreviate-filename-function 'expand-file-name
   org-download-screenshot-method "gnome-screenshot -a -f %s"
   org-download-timestamp "%Y-%m-%d_%H-%M-%S"
   org-download-display-inline-images t
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

(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats
      '("<%Y-%m-%d>" . "<%d/%m/%y %a %H:%M>"))
(setq org-latex-active-timestamp-format "\\texttt{%s}")

(defun org-export-filter-timestamp-remove-brackets (timestamp backend info)
  "removes relevant brackets from a timestamp"
  (cond
   ((org-export-derived-backend-p backend 'latex)
    (replace-regexp-in-string "[<>]\\|[][]" "" timestamp))
   ((org-export-derived-backend-p backend 'html)
    (replace-regexp-in-string "&[lg]t;\\|[][]" "" timestamp))))
(eval-after-load 'ox '(add-to-list
                       'org-export-filter-timestamp-functions
                       'org-export-filter-timestamp-remove-brackets))

(defvar org-export-output-directory-prefix "exports/"
  "Prefix of directory used for org-mode export")

(defadvice org-export-output-file-name (before org-add-export-dir activate)
  "Modifies org-export to place exported files in a different directory"
  (when (not pub-dir)
    (setq pub-dir org-export-output-directory-prefix)
    (when (not (file-directory-p pub-dir))
      (make-directory pub-dir))))

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
(setq org-latex-compiler "xelatex")
(setq org-export-with-broken-links 'mark)

(setcdr (assoc "\\.pdf\\'" org-file-apps) "flatpak run org.mozilla.firefox %s")

;; \\setmainfont{Inter}

(setq org-latex-classes
'(("article"
"\\RequirePackage{fix-cm}
\\PassOptionsToPackage{svgnames}{xcolor}
\\documentclass[11pt]{article}
\\usepackage[T1]{fontenc}
\\usepackage{unicode-math}
\\usepackage{fontsetup}
\\usepackage{pdfpages}
\\usepackage{babel}
\\usepackage{sectsty}
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
\\usepackage{amsmath,amscd,amssymb}
\\usepackage{subfiles,comment,units,subfig,fontawesome,graphicx,verbatim,nicefrac,ifthen,booktabs}
\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\fancyhead{}
\\fancyfoot{}
\\fancyhead[R]{\\thepage}
\\fancyhead[L]{\\textit{\\thedate}}
\\fancyhead[C]{\\thetitle}
\\input{~/.latex/setup.tex}
\\bibliography{~/Documents/refs.bib}
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

(setq org-format-latex-header
"\\documentclass{article}
\\usepackage[usenames]{color}
\\usepackage[T1]{fontenc}
\\usepackage{unicode-math}
\\usepackage{babel}
\\usepackage{sectsty}
\\usepackage{enumitem}
%% Math
\\usepackage{amsmath,amscd,amssymb}
\\usepackage{subfiles,comment,units,subfig,fontawesome,graphicx,verbatim,nicefrac,ifthen,booktabs}
\\input{~/.latex/setup.tex}
[DEFAULT-PACKAGES]
[PACKAGES]
\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}"
)
