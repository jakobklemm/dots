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

	("q" "Quote" entry (function inbox-file)
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
      )

(setq org-log-done 'note
      org-log-redeadline 'note
      org-log-refile 'note
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
				  :if-new (file+head "main/${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )

				 ("r" "Reference" plain
				  "%?"
				  :if-new (file+head "references/${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :reference\n"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )

				 ("c" "Capture" plain
				  "%?"
				  :if-new (file+head "${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :capture\n"
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

(use-package org-roam-ui
  :after org-roam
  :custom
  ((org-roam-ui-sync-theme t)
   (org-roam-ui-follow t)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))

(use-package deft
  :config
  (setq deft-directory "~/org/") 
  (setq deft-extensions '("org"))
  (setq deft-recursive t)
  )

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

(setq spacemacs-theme-org-agenda-height nil
      org-agenda-time-grid '((daily today require-timed) "----------------------" nil)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      '(("z" "Custom agenda"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :scheduled today
				:deadline today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '(
			  (:name "Next to do"
                                 :todo "NEXT"
                                 :order 1
				 )
			  (:discard t)
                          ))))))))

(provide 'prod)
