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

  ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
  ;; dictionary' even though multiple dictionaries will be configured
  ;; in next line.
;; (setenv "LANG" "en_US.UTF-8")
;; (setq ispell-program-name "hunspell")
;;   ;; Configure German, Swiss German, and two variants of English.
;; (setq ispell-dictionary "de_DE,de_CH,en_GB,en_US")
;;   ;; ispell-set-spellchecker-params has to be called
;;   ;; before ispell-hunspell-add-multi-dic will work
;; ;; (ispell-set-spellchecker-params)
;;   ;; (ispell-hunspell-add-multi-dic "de_DE,de_CH,en_GB,en_US")
;;   ;; For saving words to the personal dictionary, don't infer it from
;;   ;; the locale, otherwise it would save to ~/.hunspell_de_DE.
;; (setq ispell-personal-dictionary "~/.hunspell_personal")

;; ;; The personal dictionary file has to exist, otherwise hunspell will
;; ;; silently not use it.
;; (unless (file-exists-p ispell-personal-dictionary)
;;   (write-region "" nil ispell-personal-dictionary nil 0))

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

;; TODO: Bibliography

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
                                                     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: %<%Y-%m-%d %a>"
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
                                  :if-new (file+head "references/%<%Y%m%d>.org"
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
  )

(setcdr (assoc "\\.pdf\\'" org-file-apps) "firefox %s")

;; Exporting

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
