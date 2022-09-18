;; Prod

(add-hook 'org-capture-mode-hook 'evil-insert-state)
(setq org-capture-templates
      `(
	("t" "Task" entry (function inbox-file)
	 "* TODO %?
:PROPERTIES:
:DATE: %t
:SOURCE: %l
:END:
"
	 )

	("n" "Note" entry (function inbox-file)
	 "* NOTE %?
:PROPERTIES:
:DATE: %t
:SOURCE: %l
:END:
"
	 )

	("w" "Quote" entry (function inbox-file)
	 "* QUOTE %?
:PROPERTIES:
:DATE: %t
:SOURCE: %l
:END:
%i
"
	 )

	("c" "Contact" entry (function inbox-file)
	 "* NOTE %?
:PROPERTIES:
:DATE: %t
:SOURCE: %l
:CONTEXT:
:NAME:
:FIRSTNAME:
:PHONE:
:EMAIL:
:END:

Relevance:
Description:
"
	 )

	("p" "Purchase" entry (function inbox-file)
	 "* NOTE %?
:PROPERTIES:
:DATE: %t
:SOURCE: %l
:PRODUCT:
:SITE: %^L
:END:

Description:
Reason:
"
	 )

	("b" "Book" entry (file "~/org/active/ref.org")
	 "* %?
:PROPERTIES:
:DATE: %t
:SOURCE: %l
:AUTHOR:
:END:

Context:
Reason:
"
	 )

	)
      )

(defun inbox-file ()
  (find-file "~/org/active/ref.org")
  )

(setq org-todo-keywords
      '(
	(sequence "TODO(t)" "NEXT(n)" "BLOCKED(b)" "|" "DONE(d)" "SEP(s)")
	(sequence "NOTE(r)" "LINK(l)" "QUOTE(q)" "|" "ARCHIVE(a)")
	)
      org-todo-keyword-faces
      '(("TODO" . (:foreground "#af1212" :weight bold))
	("NEXT" . (:foreground "#a8fa80" :weight bold))
	("BLOCKED" . (:foreground "#b213c4" :weight bold))
	("SEP" . (:foreground "#30bb03" :weight bold))
	("NOTE" . (:foreground "#eaa222" :weight bold))
	("LINK" . (:foreground "#eaa222" :weight bold))
	("DONE" . (:foreground "#ffffff" :weight bold))
	)
      )

(setq org-log-done 'time
      org-log-redeadline 'time
      org-log-refile 'time
      )

;; Refile

;; https://yiming.dev/blog/2018/03/02/my-org-refile-workflow/
(defun +org/opened-buffer-files ()
  "Return the list of files currently opened in emacs"
  (delq nil
        (mapcar (lambda (x)
                  (if (and (buffer-file-name x)
                           (string-match "\\.org$"
                                         (buffer-file-name x)))
                      (buffer-file-name x)))
                (buffer-list))))

(setq org-refile-targets '((+org/opened-buffer-files :maxlevel . 9)))

(setq org-refile-use-outline-path 'file)
;; makes org-refile outline working with helm/ivy
;; (setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(defun jk/org-search ()
  (interactive)
  (org-refile '(4)))

;; Archive
(setq org-archive-location "~/org/archive/2022.org::* From %s")

(defun jk/done-archive ()
  "Mark done and archive."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree)
  )

(defun jk/instert-template ()
  "Insert a custom template from templates directory."
  (interactive)
  (insert-file-contents (read-file-name "Select template:" "~/org/templates/"))
  )

(use-package org-roam
  :custom
  (
   (org-roam-db-location "~/Documents/org-roam.db")
   (org-roam-directory "~/org/database/")
   (org-roam-v2-ack t)
   (org-roam-completion-everywhere t)
   (org-roam-capture-templates '(
				 ("d" "Direct" plain
				  "%?"
				  :if-new (file+head "main/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
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

				 ("c" "Capture" plain
				  "%?"
				  :if-new (file+head "%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :capture:\n"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
				 ))
   )
  :config
  (org-roam-db-autosync-mode)
  (org-roam-db-autosync-enable)
  )

(setq org-roam-node-display-template
      (concat "${tags:20}: ${title:*}"))

(use-package org-roam-ui
  :after org-roam
  :custom
  ((org-roam-ui-sync-theme t)
   (org-roam-ui-follow t)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))

(use-package org-roam-timestamps
  :config
  (setq org-roam-timestamps-remember-timestamps t)
  (setq org-roam-timestamps-minimum-gap 3600)
  )

(use-package org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref))

(use-package org-caldav
  :custom
  ((org-caldav-url "https://cloud.jeykey.net/remote.php/dav/calendars/jeykey/")
   (org-caldav-calendar-id "events")
   (org-caldav-inbox "~/org/active/ref.org")
   (org-caldav-files '())
   (org-caldav-timezone "Europe/Berlin")
   )
  )

(defun jk/todo-done ()
  (interactive)
  (org-todo 'done)
  )

(use-package openwith
  :config
  (openwith-mode)
  )

(custom-set-variables
 '(openwith-associations
   '(("\\.pdf\\'" "firefox"
      (file))
     ("\\.mp3\\'" "xmms"
      (file))
     ("\\.\\(?:mpe?g\\|avi\\|wmv\\)\\'" "mplayer"
      ("-idx" file))
     ("\\.\\(?:jp?g\\|png\\)\\'" "gwenview"
      (file)))))

(require 'org-mouse)

(provide 'prod)
