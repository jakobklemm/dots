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

;; Olivetti mode for focused writing
(use-package! olivetti
  :config
  (setq olivetti-body-width 100)  ; Adjust width to your preference

  ;; Disable line numbers and increase font size in olivetti mode
  (add-hook 'olivetti-mode-hook
            (lambda ()
              (if olivetti-mode
                  (progn
                    (display-line-numbers-mode -1)
                    (text-scale-increase 2))
                (progn
                  (display-line-numbers-mode 1)
                  (text-scale-increase 0)))))

  ;; Keybinding: Leader-T-Z
  (map! :leader
        :prefix "t"
        :desc "Toggle olivetti mode" "z" #'olivetti-mode))

;; ============================================================================
;; Completion Framework - Modern, Fast, and Intelligent
;; ============================================================================

;; Vertico - Performant vertical completion UI
(use-package! vertico
  :init
  (vertico-mode)
  :config
  ;; Enable cycling for better navigation
  (setq vertico-cycle t
        vertico-resize nil
        vertico-count 17)

  ;; Enable vertico extensions
  (require 'vertico-directory)
  (require 'vertico-quick)
  (require 'vertico-repeat)
  (require 'vertico-buffer)

  ;; Better directory navigation
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

  ;; Keybindings for vertico-quick (jump to candidate by prefix)
  (define-key vertico-map "\M-q" #'vertico-quick-insert)
  (define-key vertico-map "\C-q" #'vertico-quick-exit)

  ;; Better scrolling
  (define-key vertico-map "\C-n" #'vertico-next)
  (define-key vertico-map "\C-p" #'vertico-previous)

  ;; Accept current input exactly as written (useful for creating new files)
  (define-key vertico-map (kbd "C-<return>") #'vertico-exit-input)

  ;; Save vertico history
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save))

;; Orderless - Flexible, powerful completion style
(use-package! orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; Enable partial-completion for file paths
  (completion-category-overrides '((file (styles partial-completion orderless))
                                   (buffer (styles orderless))
                                   (project-file (styles orderless))))
  :config
  ;; Custom orderless matching styles
  (setq orderless-matching-styles
        '(orderless-literal
          orderless-prefixes
          orderless-initialism
          orderless-regexp))

  ;; Smart case sensitivity
  (setq orderless-smart-case t)

  ;; Define custom dispatchers for special matching
  (defun orderless-fast-dispatch (word index total)
    (cond
     ;; Ensure $ works as suffix
     ((string-suffix-p "$" word)
      `(orderless-regexp . ,(concat (substring word 0 -1) "$")))
     ;; Ensure ^ works as prefix
     ((string-prefix-p "^" word)
      `(orderless-regexp . ,(substring word 1)))
     ;; ! for negation
     ((string-prefix-p "!" word)
      `(orderless-without-literal . ,(substring word 1)))
     ;; = for literal matching
     ((string-prefix-p "=" word)
      `(orderless-literal . ,(substring word 1)))
     ;; % for char-fold (e.g., a matches ä, à, etc.)
     ((string-prefix-p "%" word)
      `(orderless-char-fold-to-regexp . ,(substring word 1)))))

  (setq orderless-style-dispatchers '(orderless-fast-dispatch)))

;; Marginalia - Rich annotations in completion candidates
(use-package! marginalia
  :init
  (marginalia-mode)
  :config
  (setq marginalia-align 'right
        marginalia-align-offset -1)

  ;; Cycle through annotation levels
  (map! :map minibuffer-local-map
        "M-A" #'marginalia-cycle))

;; Consult - Practical commands using completing-read
(use-package! consult
  :config
  ;; Better register preview
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Improve register preview formatting
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Consult customization
  (setq consult-narrow-key "<"
        consult-line-numbers-widen t
        consult-async-min-input 2
        consult-async-refresh-delay 0.15
        consult-async-input-throttle 0.2
        consult-async-input-debounce 0.1
        consult-preview-key 'any)

  ;; Configure preview for different commands
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key
  (setq consult-project-function (lambda (_) (projectile-project-root)))

  ;; Enhanced keybindings
  (map! :leader
        :prefix "s"
        :desc "Search line" "l" #'consult-line
        :desc "Search line (multi)" "L" #'consult-line-multi
        :desc "Search outline" "o" #'consult-outline
        )

  (map! :leader
        :prefix "b"
        :desc "Switch buffer" "b" #'consult-buffer
        )
  )

;; Corfu - In-buffer completion popup
(use-package! corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2)
  (corfu-quit-at-boundary 'separator)
  (corfu-quit-no-match 'separator)
  (corfu-preview-current nil)
  (corfu-preselect 'prompt)
  (corfu-scroll-margin 5)
  :init
  (global-corfu-mode)
  :config
  ;; Enable Corfu in the minibuffer (useful for eval expressions)
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico is not active."
    (when (not (bound-and-true-p vertico--input))
      (setq-local corfu-auto nil)
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

  ;; Better navigation
  (map! :map corfu-map
        "TAB" #'corfu-next
        [tab] #'corfu-next
        "S-TAB" #'corfu-previous
        [backtab] #'corfu-previous
        "RET" #'corfu-insert
        [return] #'corfu-insert))

;; Cape - Completion At Point Extensions
(use-package! cape
  :config
  ;; Add useful completion sources
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)

  ;; Keybindings for manual completion
  (map! :leader
        :prefix "i"
        :desc "Complete file" "f" #'cape-file
        :desc "Complete dabbrev" "d" #'cape-dabbrev
        :desc "Complete line" "l" #'cape-line
        :desc "Complete keyword" "k" #'cape-keyword
        :desc "Complete abbrev" "a" #'cape-abbrev))

;; Enhanced history and saving
(use-package! savehist
  :init
  (savehist-mode)
  :config
  (setq savehist-file "~/.doom.d/.savehist"
        history-length 1000
        history-delete-duplicates t
        savehist-save-minibuffer-history t
        savehist-additional-variables
        '(kill-ring
          search-ring
          regexp-search-ring
          last-kbd-macro
          kmacro-ring
          shell-command-history
          register-alist))

  ;; Force UTF-8 encoding for savehist file to prevent encoding prompts
  (add-hook 'savehist-save-hook
            (lambda ()
              (setq buffer-file-coding-system 'utf-8-unix))))

;; Prescient - Intelligent sorting and filtering
(use-package! prescient
  :config
  (setq prescient-history-length 1000
        prescient-save-file "~/.doom.d/.prescient-save"
        prescient-filter-method '(literal regexp initialism fuzzy)
        prescient-sort-full-matches-first t)

  ;; Force UTF-8 encoding for prescient save file
  (defun prescient--save-with-utf8 (orig-fun &rest args)
    "Ensure prescient saves with UTF-8 encoding."
    (let ((coding-system-for-write 'utf-8-unix))
      (apply orig-fun args)))
  (advice-add 'prescient--save :around #'prescient--save-with-utf8)

  (prescient-persist-mode +1))

(use-package! vertico-prescient
  :after vertico
  :config
  (setq vertico-prescient-enable-filtering t
        vertico-prescient-enable-sorting t)
  (vertico-prescient-mode +1))

(use-package! corfu-prescient
  :after corfu
  :config
  (corfu-prescient-mode +1))

;; Which-key integration for better discoverability
(after! which-key
  (setq which-key-idle-delay 0.5
        which-key-idle-secondary-delay 0.05
        which-key-sort-order 'which-key-prefix-then-key-order))

(use-package! popper
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*Warnings\\*"
          "\\*compilation\\*"
          "\\*Completions\\*"
          "\\*Backtrace\\*"
          help-mode
          compilation-mode
          flycheck-error-list-mode
          occur-mode))

  :config
  ;; Match the windows of below types as popups
  (setq popper-display-control t)

  ;; Customize popup display behavior
  (setq popper-display-function #'popper-select-popup-at-bottom)

  ;; Enable popper mode
  (popper-mode +1)
  (popper-echo-mode +1)

  ;; Keybindings
  (global-set-key (kbd "C-,") #'popper-toggle)
  (global-set-key (kbd "C-.") #'popper-cycle))

;; Prevent org-mode from overwriting C-, keybinding
(after! org
  (define-key org-mode-map (kbd "C-,") nil))

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
                             (?\s . "☐"))
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
 "SPC" #'consult-buffer
 "r" #'consult-recent-file)

(map!
 :leader
 :prefix ("f" . "file")
 "g" #'consult-ripgrep)

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
  (set-face-attribute 'svg-tag-default-face nil :family "MonaspiceAr Nerd Font Mono")

  (setq svg-tag-tags
        '(
          ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :margin 0 :padding 1 :radius 5 :height 0.7))))
          ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0 :padding 1 :radius 5 :height 0.7))))
          ("BLOCKED" . ((lambda (tag) (svg-tag-make "BLOCKED" :face 'error :margin 0 :padding 1 :radius 5 :height 0.7))))
          ("GEN" . ((lambda (tag) (svg-tag-make "GEN" :face 'warning :margin 0 :padding 1 :radius 5 :height 0.7))))
          ("SEP" . ((lambda (tag) (svg-tag-make "SEP" :face 'success :margin 0 :padding 1 :radius 5 :height 0.7))))

          ("\\(:[A-Za-z0-9_@#%]+:\\)" . ((lambda (tag)
                                           (svg-tag-make tag :beg 1 :end -1
                                                         :face 'org-tag
                                                         :margin 0
                                                         :padding 1
                                                         :radius 5
                                                         :height 0.7
                                                         )
                                           )
                                         )
           )
          )
        )

  :hook (org-mode . svg-tag-mode)
  )

;; Org heading sizes - create visual hierarchy
(custom-set-faces!
  '(org-level-1 :height 1.4 :weight bold)
  '(org-level-2 :height 1.3 :weight semi-bold)
  '(org-level-3 :height 1.2 :weight semi-bold)
  '(org-level-4 :height 1.1 :weight normal)
  '(org-level-5 :height 1.0 :weight normal)
  '(org-level-6 :height 1.0 :weight normal)
  '(org-level-7 :height 1.0 :weight normal)
  '(org-level-8 :height 1.0 :weight normal)
  '(org-document-title :height 1.6 :weight bold))

;; Declutter org-mode UI
(after! org
  (setq org-startup-indented t  ; Clean indentation
        org-adapt-indentation nil  ; Don't indent content
        org-startup-folded 'content  ; Start with content folded
        org-cycle-separator-lines 2  ; More breathing room
        org-fontify-whole-heading-line t  ; Better heading visibility
        org-fontify-done-headline t  ; Highlight done items
        org-fontify-quote-and-verse-blocks t))  ; Better block styling

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
