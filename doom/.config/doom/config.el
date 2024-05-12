;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Jakob Klemm"
      user-mail-address "github@jeykey.net")

(setq doom-font "Monaspace Argon")
(setq doom-theme 'doom-henna)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

;; ;; Default settings (https://tecosaur.github.io/emacs-config/config.html#simple-settings)
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      ;; scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 2                             ; It's nice to maintain a little margin
      display-time-default-load-average nil)      ; I don't think I've ever found this useful

(display-time-mode 1)                             ; Enable time in the mode-line

(global-subword-mode 1)                           ; Iterate through CamelCase words

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq which-key-idle-delay 0.5)

(setq display-line-numbers-type 'relative)

;; Windows (https://tecosaur.github.io/emacs-config/config.html#windows)
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

(use-package! vertico-posframe
  :config
  (setq vertico-posframe-parameters
      '((left-fringe . 8)
        (right-fringe . 8)))
  (vertico-posframe-mode 1)
  )

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

(setq langtool-http-server-host "172.16.110.22"
      langtool-http-server-port 8010)

(use-package! langtool-ignore-fonts
  :config
  (add-hook 'org-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'markdown-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'LaTeX-mode-hook 'langtool-ignore-fonts-minor-mode))

(setq yas-triggers-in-field t)

(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(setq +zen-text-scale 1.2)
(setq +zen-mixed-pitch-modes '())

(use-package! popper
  :bind (("C-,"   . popper-toggle-latest)
         ("M-,"   . popper-cycle)
         ("C-M-," . popper-toggle-type))
  :custom
  ((popper-reference-buffers
    '("\\*Messages\\*"
      "Output\\*$"
      "\\*Async Shell Command\\*"
      "\\*Backtrace\\*"
      help-mode
      compilation-mode)))
  :init
  (popper-mode +1)
  (popper-echo-mode +1)
  )

(setq org-agenda-files (list org-directory)                  ; Seems like the obvious place.
      org-use-property-inheritance t                         ; It's convenient to have properties inherited.
      org-log-done 'time                                     ; Having the time a item is done sounds convenient.
      org-list-allow-alphabetical t                          ; Have a. A. a) A) list bullets.
      org-catch-invisible-edits 'smart                       ; Try not to accidently do weird stuff in invisible regions.
      org-export-with-sub-superscripts '{}                   ; Don't treat lone _ / ^ as sub/superscripts, require _{} / ^{}.
      org-export-allow-bind-keywords t                       ; Bind keywords can be handy
      org-image-actual-width '(0.9))

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq org-ellipsis " ▾ "
      org-hide-leading-stars t
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue)))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
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
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo))
  )

(use-package! svg-tag-mode
  :config
  (set-face-attribute 'svg-tag-default-face nil :family "Carlito Bold")
  :hook (org-mode . svg-tag-mode)
  )

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  ((org-hide-emphasis-markers t)
   (org-appear-autoemphasis t)
   (org-appear-autolinks t)
   (org-appear-autosubmarkers t))
  )

(use-package! org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode)
  )

(use-package org-roam
  :init
  (map! :leader
        :prefix "n"
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-buffer-toggle" "t" #'org-roam-buffer-toggle
        :desc "org-roam-dailies-today" "d" #'org-roam-dailies-goto-today
        :desc "org-roam-dailies-capture" "e" #'org-roam-dailies-capture-today
        )
  :custom
  (
   (org-roam-db-location "~/Documents/org-roam.db")
   (org-roam-directory "~/org/database/")
   (org-roam-dailies-directory "daily/")
   (org-roam-v2-ack t)
   (org-roam-completion-everywhere t)
   (org-roam-capture-templates '(
                                 ("d" "Direct" plain
                                  "%?"
                                  :if-new (file+head "main/%<%Y%m%d>-${slug}.org"
                                                     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: %<%Y-%m-%d %a>"
                                                     )
                                  :immediate-finish t
                                  :unnarrowed t
                                  )
                                 ("e" "ETH" plain
                                  "%?"
                                  :if-new (file+head "eth/%<%Y%m%d>-${slug}.org"
                                                     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: %<%Y-%m-%d %a>\n\nSource: \n\n\n* Anki   :noexport:\n** _\n"
                                                     )
                                  :immediate-finish t
                                  :unnarrowed t
                                  )
                                 ("t" "Tech" plain
                                  "%?"
                                  :if-new (file+head "docs/%<%Y%m%d>-${slug}.org"
                                                     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: %<%Y-%m-%d %a>"
                                                     )
                                  :immediate-finish t
                                  :unnarrowed t
                                  )
                                 ("o" "Output" plain
                                  "%?"
                                  :if-new (file+head "out/%<%Y%m%d>-${slug}.org"
                                                     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: %<%Y-%m-%d %a>"
                                                     )
                                  :immediate-finish t
                                  :unnarrowed t
                                  )
                                 ("r" "Reference" plain
                                  "%?"
                                  :if-new (file+head "references/%<%Y%m%d>-${slug}.org"
                                                     "#+TITLE: ${title}\n#+FILETAGS: :reference:\n"
                                                     )
                                  :immediate-finish t
                                  :unnarrowed t
                                  )
                                 ("p" "Project" plain
                                  "%?"
                                  :if-new (file+head "projects/${slug}.org"
                                                     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: %<%Y-%m-%d %a>"
                                                     )
                                  :immediate-finish t
                                  :unnarrowed t
                                  )

                                 ))
   )
  :config
  (org-roam-db-autosync-mode)
  (org-roam-db-autosync-enable)
  (require 'org-roam-dailies)
  )

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %<%I:%M %p>: %?"
         :if-new (file+head "%<%Y-%m-%d>.org.gpg" "#+title: %<%Y-%m-%d>\n"))))

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

(setcdr (assoc "\\.pdf\\'" org-file-apps) "flatpak run org.mozilla.firefox %s")

;; Exporting

(setq-default org-display-custom-times t)
;;; Before you ask: No, removing the <> here doesn't work.
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

;; https://tecosaur.github.io/emacs-config/config.html#general-settings
(setq org-export-headline-levels 5)

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(use-package! engrave-faces-latex
  :after ox-latex
  :config
  (setq org-latex-listings 'engraved)
  )

(defadvice! org-latex-example-block-engraved (orig-fn example-block contents info)
  "Like `org-latex-example-block', but supporting an engraved backend"
  :around #'org-latex-example-block
  (let ((output-block (funcall orig-fn example-block contents info)))
    (if (eq 'engraved (plist-get info :latex-listings))
        (format "\\begin{Code}[alt]\n%s\n\\end{Code}" output-block)
      output-block)))

(setq org-latex-compiler "xelatex")

(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "grffile" t)
        ("" "longtable" nil)
        ("" "wrapfig" nil)
        ("" "rotating" nil)
        ("normalem" "ulem" t)
        ("" "amsmath" t)
        ("" "textcomp" t)
        ("" "amssymb" t)
        ("" "capt-of" nil)
        ("" "hyperref" nil)))

;; Makes export respect new lines, but also auto-fill 80 width
;; (setq org-export-preserve-breaks t)

(use-package! org-special-block-extras
  :hook
  (org-mode . org-special-block-extras-mode)
  )

(add-to-list 'company-backends 'company-math-symbols-unicode)

(setq org-export-with-broken-links 'mark)

(setq org-latex-classes
'(("article"
"\\RequirePackage{fix-cm}
\\PassOptionsToPackage{svgnames}{xcolor}
\\documentclass[11pt]{article}
\\usepackage[T1]{fontenc}
\\usepackage{unicode-math}
\\usepackage{fontsetup}
\\setmainfont{Inter}
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
\\fancyhead[R]{\\texttt{\\thepage}}
\\fancyhead[L]{\\thedate}
\\fancyhead[C]{\\texttt{\\thetitle}}
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

(after! citar
  (setq! citar-bibliography '("~/Documents/refs.bib"))
  (setq! citar-library-paths '("~/files/references/"))
  (setq! citar-notes-paths '("~/files/notes/"))
  (setq! org-cite-global-bibliography '("~/Documents/refs.bib"))
  )

(setq org-cite-csl-styles-dir "~/Zotero/styles")
(setq org-cite-csl--fallback-style-file "~/Zotero/styles/ieee.csl")

(use-package! citar-org-roam
  :after (citar org-roam)
  :config (citar-org-roam-mode)
  )

(defun jk/print-bib ()
  (interactive)
  (insert "#+PRINT_BIBLIOGRAPHY: \n")
  )

;; Custom binds
(map! :leader
      :prefix "c"
      "o" #'citar-open
      "i" #'citar-insert-citation
      "p" #'jk/print-bib
      )

;; Page
(require 'ox-publish)
(use-package! htmlize)

(setq org-publish-project-alist
      (list
       (list "site"
             :recursive nil
             :base-directory "~/Documents/jeykey.net/content/"
             :with-author nil
             :with-creator nil
             :with-date t
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file t
             :section-numbers nil
             :auto-sitemap nil
             :sitemap-format-entry 'jk/build-entry
             :publishing-directory "~/Documents/jeykey.net/public/"
             :publishing-function 'org-html-publish-to-html
             )
       (list "posts"
	     :recursive t
             :base-directory "~/Documents/jeykey.net/content/posts/"
             :with-author nil
             :with-creator nil
             :with-date t
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file t
             :section-numbers nil
             :auto-sitemap t
             :sitemap-sort-files 'anti-chronologically
             :sitemap-title "Overview"
             :sitemap-filename "overview.html"
             :sitemap-date-format "%d.%m.%Y"
             :sitemap-format-entry 'jk/build-entry
	         :sitemap-function 'jk/build-sitemap
             :publishing-directory "~/Documents/jeykey.net/public/posts/"
             :publishing-function 'org-html-publish-to-html
	     )
       (list "static"
             :base-directory "~/Documents/jeykey.net/content/static/"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|asc"
             :publishing-directory "~/Documents/jeykey.net/public/static/"
             :publishing-function 'org-publish-attachment
             :recursive t)
       (list "style"
             :base-directory "~/Documents/jeykey.net/style/"
             :base-extension "css\\|js"
             :publishing-directory "~/Documents/jeykey.net/public/style/"
             :publishing-function 'org-publish-attachment
             :recursive t)
       ))

(defun jk/build-entry (a b c)
  "Defines format of sitemap entries."
  (format "- %s: [[file:%s][%s]]" (format-time-string "%d.%m.%Y" (org-publish-find-date a c)) a (org-publish-find-title a c))
  )

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-html-head "
<meta name=\"author\" content=\"Jakob Klemm\">
<link rel=\"stylesheet\" href=\"/style/style.css\" />
<h1><a href=\"/\">Jakob Klemm</a></h1>
<div class=\"hdr\">
<a href=\"/posts/overview.html\">Overview</a>
<a href=\"/about.html\">About</a>
<a href=\"https://github.com/jakobklemm/\">Github</a>
<a href=\"mailto:github@jeykey.net\">Contact</a>
</div>
")

(defun jk/publish-site ()
  (interactive)
  (delete-directory "~/Documents/jeykey.net/public/" t)
  (org-publish-remove-all-timestamps)
  (org-publish-all t)
  )

;; https://djliden.github.io/posts/20211203-this-site.html
(defun jk/build-sitemap (title list)
   "Sitemap generation function."
   (concat "#+OPTIONS: toc:nil")
   (org-list-to-subtree list)
   )

;; Anki
;; https://yiufung.net/post/anki-org/
(use-package anki-editor
  :after org
  :bind (:map org-mode-map
              ("<f12>" . anki-editor-cloze-region-auto-incr)
              ("<f11>" . anki-editor-cloze-region-dont-incr)
              ("<f10>" . anki-editor-reset-cloze-number)
              ("<f9>"  . anki-editor-push-tree))
  :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
  :config
  (setq anki-editor-create-decks t ;; Allow anki-editor to create a new deck if it doesn't exist
        anki-editor-org-tags-as-anki-tags t)

  (defun anki-editor-cloze-region-auto-incr (&optional arg)
    "Cloze region without hint and increase card number."
    (interactive)
    (anki-editor-cloze-region my-anki-editor-cloze-number "")
    (setq my-anki-editor-cloze-number (1+ my-anki-editor-cloze-number))
    (forward-sexp))
  (defun anki-editor-cloze-region-dont-incr (&optional arg)
    "Cloze region without hint using the previous card number."
    (interactive)
    (anki-editor-cloze-region (1- my-anki-editor-cloze-number) "")
    (forward-sexp))
  (defun anki-editor-reset-cloze-number (&optional arg)
    "Reset cloze number to ARG or 1"
    (interactive)
    (setq my-anki-editor-cloze-number (or arg 1)))
  (defun anki-editor-push-tree ()
    "Push all notes under a tree."
    (interactive)
    (anki-editor-push-notes '(4))
    (anki-editor-reset-cloze-number))
  ;; Initialize
  (anki-editor-reset-cloze-number)
  )

(setq org-screenshot-image-directory "~/files/database/org/")

;; org-roam-meili
(defun my-org-copy-subtree-contents ()
  "Get the content text of the subtree at point and add it to the `kill-ring'.
Excludes the heading and any child subtrees."
  (interactive)
  (if (org-before-first-heading-p)
      (message "Not in or on an org heading")
    (save-excursion
      ;; If inside heading contents, move the point back to the heading
      ;; otherwise `org-agenda-get-some-entry-text' won't work.
      (unless (org-on-heading-p) (org-previous-visible-heading 1))
      (let ((contents (substring-no-properties
                       (org-agenda-get-some-entry-text
                        (point-marker)
                        most-positive-fixnum))))
        (message "Copied: %s" contents)
        (kill-new contents)))))

(use-package! org-download
  :config
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq-default org-download-image-dir "~/files/database/auto/")
  (setq-default org-download-abbreviate-filename-function 'concat)
  )

(require 'request)

;; Define server URL and headers
(defvar my-url "https://meili.local.jeykey.net/indexes/org-roam/documents")
(defvar my-headers '(("Content-Type" . "application/json")))

(defun upld (node)
  (setq o-n-id (car node))
  (setq o-n-tx (org-roam-ui--get-text o-n-id))
  (let ((json-obj (json-encode `(("id" . ,o-n-id)("body" . ,o-n-tx)))))
    (request my-url
      :type "POST"
      :headers my-headers
      :data (encode-coding-string json-obj 'utf-8)
      :parser 'json-read
      )
    )
  )

(defun convert-list-of-structs-to-json (struct-list)
  "Convert a list of structs to JSON objects and return a new list containing all the JSON objects."
  (mapcar
   (lambda (struct)
     (let* ((id (car struct))
            (node (org-roam-node-from-id id))
            (title (org-roam-node-title node))
            (body (org-roam-ui--get-text id))
            (parsed `(("id" . ,id)("title" . ,title)("body" . ,body)))
            )
       parsed
       ))
     ;; (let ((json-object (json-encode struct)))
     ;; json-object))
   struct-list))

(setq nodes (org-roam-db-query [:select * :from nodes]))
;; (setq nnodes (convert-list-of-structs-to-json nodes))
;; (setq nnnodes (json-encode nnodes))
;; (request my-url
;;       :type "POST"
;;       :headers my-headers
;;       :data (encode-coding-string nnnodes 'utf-8)
;;       :parser 'json-read
;;       )

(defun meili-query (str)
  (let* ((data2  `(("q" . "CIDR")("cropLength" . 8)("attributesToCrop" . ("body"))))
         (data  `(("q" . "CIDR")))
         (encoded (json-encode data))
         (resp (request "https://meili.local.jeykey.net/indexes/org-roam/search"
                 :type "POST"
                 :headers my-headers
                 :data (encode-coding-string encoded 'utf-8)
                 :parser 'json-read
                 ;; :parser (lambda () (json-parse-buffer :object-type 'hash-table))
                 )
               )
         ;; (ret (json-parse-string resp :object-type 'hash-table))
        )
    (message "ENC: %s" encoded)
    (message "REP: %s" resp)
    (let ((data (request-response-data resp)))
      (message "DATA : %s" data)
      (let* ((dta (json-parse-string data))
             (hits (gethash "hits" dta)))
        (mapcar (lambda (hit)
                  (let* ((title (gethash "title" hit)))
                    title
                    ))
                hits
                )
              )
            )
      )

    ;; (let ((data (plist-get (car (cdr resp)) :data)))
    ;;   (let* ((dta (json-parse-string data))
    ;;          (hits (gethash "hits" dta)))
    ;;     (mapcar (lambda (hit)
    ;;               (let* ((title (gethash "title" hit)))
    ;;                 title
    ;;                 ))
    ;;             hits
    ;;             )
    ;;           )
    ;;         )
    ;;   )
  )

(defun complete-meili (str pred flag)
  ;; (message "%s" str)
  (meili-query str)
  )

(defun jk-test-completion ()
  (interactive)
  (completing-read "Node: " #'complete-meili)
  )
