(use-package org
  :defer t
  :hook
  (org-mode . org-toggle-inline-images)
  (org-mode . org-indent-mode)
  (text-mode . flyspell-mode)
  (org-mode . flyspell-mode)
  :custom
  ((org-log-done 'time)
   (org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
      (sequence "PROCESS(p)" "BLOCKED(b)" "|" "PAL(a)")))
   (org-todo-keyword-faces
    '(("TODO" . (:foreground "#af1212" :weight bold))
      ("NEXT" . (:foreground "#a8fa80" :weight bold))
      ("BLOCKED" . (:foreground "#b213c4" :weight bold))
      ("PAL" . (:foreground "#30bb03" :weight bold))
      ("PROCESS" . (:foreground "#eaa222" :weight bold))
      ("DONE" . (:foreground "#ffffff" :weight bold))
      ))
   (org-tag-alist '(("home" . ?h)
                    ("actaeon" . ?a)
                    ("orion" . ?o)
                    ("schule" . ?s)
                    ))
   (org-agenda-deadline-faces
	  '((1.001 . error)
	    (1.0 . org-warning)
	    (0.5 . org-upcoming-deadline)
	    (0.0 . org-upcoming-distant-deadline)))
   (org-directory "~/documents/")
   (org-archive-location "~/archive/2021.org::* From %s")
   (org-agenda-files '("~/supervisor/supervisor.org"))
   (org-image-actual-width '(600))
   (org-ellipsis " ▼ ")
   (org-adapt-indentation nil)
   (org-fontify-quote-and-verse-blocks t)
   (org-startup-folded t)
   (org-priority-highest ?A)
   (org-priority-lowest ?C)
   (org-priority-faces
    '((?A . 'all-the-icons-red)
      (?B . 'all-the-icons-orange)
      (?C . 'all-the-icons-yellow)))
   (org-src-tab-acts-natively t)
   (org-hide-emphasis-markers t)
   (org-src-window-setup 'current-window)
   (org-return-follows-link t)
   (org-confirm-babel-evaluate nil)
   (org-use-speed-commands t)
   (org-catch-invisible-edits 'show)
   (ispell-program-name "hunspell")
   (ispell-local-dictionary "de_DE")
   (ispell-local-dictionary-alist
    '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
      ("de_DE" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE" "-a" "-i" "UTF-8") nil utf-8)))
   )
  :config
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.60))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.40))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.20))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
   )
  (setq-default org-display-inline-images t)
  (setq-default org-startup-with-inline-images t)
  (require 'tempo)
  (require 'org-tempo)
  (add-hook 'ispell-change-dictionary-hook #'flyspell-buffer)
  )

(use-package org-appear
  :defer t
  :hook (org-mode . org-appear-mode)
  :custom
  ((org-hide-emphasis-markers t)
	 (org-appear-autoemphasis t)
	 (org-appear-autolinks t)
	 (org-appear-autosubmarkers t))
  )

(use-package org-superstar
  :defer t
  :hook (org-mode . (lambda () (org-superstar-mode 1)))
  :custom
  ((org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶"))
   (org-superstar-prettify-item-bullets t)
   (org-superstar-configure-like-org-bullets t)
   (org-hide-leading-stars nil)
   (org-superstar-leading-bullet ?\s)
   (org-superstar-special-todo-items t)
   (org-superstar-todo-bullet-alist '(("TODO" "☐ ")
                                      ("NEXT" "✒ ")
                                      ("STATIC" "» ")
                                      ("BLOCKED" "˧ ")
                                      ("DONE" "✔ ")
                                      ("PAL" "✔ ")))))

(use-package org-fragtog
  :defer t
  :hook (org-mode . org-fragtog-mode)
  :custom
  ((org-latex-preview-ltxpng-directory "~/.ltxpng/")))

;; Export 

(setq-default org-startup-with-latex-preview t)

(setq TeX-parse-self t)
(setq TeX-auto-save t)

(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (setq TeX-master t)))

(eval-after-load "org" '(require 'ox-odt nil t))

(use-package htmlize
  :defer t)

(use-package ox-pandoc
  :defer t
  )

(use-package ox-hugo
  :defer t
  :config
  (setq org-hugo-auto-set-lastmod t)
  )

(use-package plantuml-mode
  :defer t
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  )

(use-package ox-reveal
  :defer t
  :custom ((org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
           (org-reveal-mathjax t)
           (org-reveal-ignore-speaker-notes nil)
           (org-reveal-note-key-char nil)))

(use-package ob-elixir
  :defer t
  )

(use-package ob-rust
  :defer t
  )

(use-package ob-go
  :defer t
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (elixir . t)
   (latex . t)
   (rust . t)
   ))

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(require 'org)
(setq org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(setq org-src-fontify-natively t)

;; Open directly PDFs in browser.
(setcdr (assoc "\\.pdf\\'" org-file-apps) "brave %s")

;; Content
(use-package org-roam
  :defer t
  )

(setq org-roam-directory "~/documents/braindump/")
(org-roam-db-autosync-mode)
(setq org-roam-v2-ack t)

(use-package org-roam-ui
  :disabled t
  :defer t
  :after org-roam
  :custom
  ((org-roam-ui-sync-theme t)
   (org-roam-ui-follow t)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))
