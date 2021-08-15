;; Inital "Emacs Procutivity System"
;; Deps: evil, general

;; Projects index
(setq jk/projects '("Common" "Actaeon" "Orion" "Schule"))

;; Agenda Navigation
(general-def org-agenda-keymap
  "h" 'org-agenda-next-line
  "t" 'org-agenda-previous-line
  "d" 'org-agenda-earlier
  "n" 'org-agenda-later
  "H" 'jk/todo-later
  "T" 'jk/todo-earlier
  "s" 'org-agenda-schedule
  )

(defun jk/todo-later  ()
  (interactive)
  (org-agenda-date-later 1)
  (org-agenda-redo)
  (org-agenda-next-item)
  )

(defun jk/todo-earlier  ()
  (interactive)
  (org-agenda-date-later -1)
  (org-agenda-redo)
  (org-agenda-previous-item)
  )

;; Agenda
(setq org-agenda-span 5
      org-agenda-start-on-weekday nil
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-current-time-string "← now"
      )

(setq
 org-agenda-skip-scheduled-if-done t
 org-agenda-skip-deadline-if-done t
 org-agenda-include-deadlines t
 org-agenda-start-with-log-mode t
 )

(setq org-agenda-custom-commands
      '(("p" "Super Agena"
         (
          (alltodo "" ((org-agenda-overriding-header "Personal Agenda")
                       (org-super-agenda-groups
                        '((:name "Today"
                                 :tag "ACTIVE"
                                 :order 1)
                          (:name "Projects"
                                 :tag "PROJECTS"
                                 :order 2
                                 )
                          (:discard (:tag ("INBOX" "EVENTS" "COMPLETED")))
                          ))))
          (agenda "" ((org-agenda-span 'week)
                      (org-agenda-overriding-header "Events")
                      (org-super-agenda-groups
                       '((
                          :name ""
                          :time-grid t
                          :tag "EVENTS"
                          :order 1
                          ))
                       (:discard (:anything t))
                       )))
          (alltodo "" ((org-agenda-overriding-header "Stack")
                       (org-super-agenda-groups
                        '((:name "Inbox"
                                 :tag "INBOX"
                                 )
                          (:name "Completed"
                                 :tag "COMPLETED"
                                 )
                          (:discard (:anything t))
                          ))))
          ))
        )
      )

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

;; Refile
(setq
 org-refile-targets '(("~/supervisor/supervisor.org" :tag . "PROJECTS")
                      ("~/supervisor/completed.org" :maxlevel . 1)
                      )

 )
	
;; Refile to specific project through selector
(defun jk/select-project (choice)
  "Select a project from the list."
  (interactive)
   (let ((completion-ignore-case  t))
     (list (completing-read "Project: " jk/projects nil t)))
  )

(defun jk/refile-project ()
  "Select project and refile heading to."
  (interactive)
  (jk/refile-to "~/supervisor/supervisor.org" (car (jk/select-project ())))
  )

;; https://emacs.stackexchange.com/questions/8045/org-refile-to-a-known-fixed-location
(defun jk/refile-to (file headline)
  "Move current headline to specified location"
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos))))

(defun jk/activate  ()
  (interactive)
  (org-todo "TODO")
  (org-schedule nil (org-read-date nil nil "+1d"))
  (org-mark-ring-push)
  (jk/refile-to "~/documents/supervisor.org" "Active")
  (org-mark-ring-goto)
  )

(defun jk/completed ()
  "Move to completed.org"
  (interactive)
  (org-mark-ring-push)
  (ivy/refile-to "~/documents/completed.org" "Week")
  (org-mark-ring-goto))

;; Capture
(setq org-capture-templates '(("c" "Inbox" entry (file+headline "~/documents/supervisor.org" "Inbox")
                               "* TODO %?\nCAPTURED: %U\n"
                               )
                              )
      )

(use-package
  org-capture
  :after org
  :hook
  (org-capture-mode . evil-insert-state)
  )

(provide 'eps)
