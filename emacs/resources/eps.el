;; Inital "Emacs Procutivity System"
;; Deps: evil, general, org-super-agenda

;; Projects index
(setq jk/projects '("Common" "Actaeon" "Orion" "Schule"))

(define-key org-agenda-mode-map (kbd "j") 'org-agenda-next-item)
(define-key org-agenda-mode-map (kbd "k") 'org-agenda-previous-item)

(define-key org-agenda-mode-map (kbd "h") 'org-agenda-next-item)
(define-key org-agenda-mode-map (kbd "t") 'org-agenda-previous-item)

(define-key org-agenda-mode-map (kbd "H") 'jk/todo-earlier)
(define-key org-agenda-mode-map (kbd "T") 'jk/todo-later)

(define-key org-agenda-mode-map (kbd "<return>") 'jk/agenda-complete)
(define-key org-agenda-mode-map (kbd "x") 'jk/agenda-done)
(define-key org-agenda-mode-map (kbd "s") 'jk/agenda-sort)
(define-key org-agenda-mode-map (kbd "a") 'jk/agenda-activate)

(defun jk/todo-later  ()
  (interactive)
  (org-agenda-date-later 1)
  (org-agenda-redo-all)
  (org-agenda-next-item)
  )

(defun jk/todo-earlier  ()
  (interactive)
  (org-agenda-date-later -1)
  (org-agenda-redo-all)
  (org-agenda-previous-item)
  )

(defun jk/supervisor ()
  (interactive)
  (find-file "~/supervisor/supervisor.org")
  )

;; Agenda
(setq org-agenda-span 5
      org-agenda-start-on-weekday nil
      ;; org-agenda-skip-scheduled-if-done t
      ;; org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-current-time-string "← now"
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
                          (:discard (:tag ("INBOX" "EVENTS")))
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
                          (:discard (:anything t))
                          ))))
          ))
        )
      )

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

;; Refile
(setq
 org-refile-targets '(("~/supervisor/supervisor.org" :maxlevel . 1)
                      ("~/supervisor/completed.org" :maxlevel . 1)
                      )
 )

(defun jk/set-done ()
  (interactive)
  (org-todo "DONE")
  )

(defun jk/agenda-done ()
  (interactive)
  (org-agenda-todo "DONE")
  )

(defun jk/select-project (choice)
  "Select a project from the list."
  (interactive)
  (let ((completion-ignore-case  t))
    (list (completing-read "Project: " jk/projects nil t)))
  )

(defun jk/buffer-refile (file headline)
  "Refile to specific file and header for org item."
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos))))

(defun jk/agenda-refile (file headline)
  "Refile to specific file and header for agenda item."
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-agenda-refile nil (list headline file nil pos))))

(defun jk/agenda-event  ()
  (interactive)
  (org-agenda-schedule)
  (org-mark-ring-push)
  (jk/agenda-refile "~/supervisor/supervisor.org" "Events")
  (org-mark-ring-goto)
  (org-agenda-redo-all)
  )

(defun jk/buffer-event  ()
  (interactive)
  (org-schedule)
  (org-mark-ring-push)
  (jk/buffer-refile "~/supervisor/supervisor.org" "Events")
  (org-mark-ring-goto)
  )

(defun jk/agenda-sort  ()
  (interactive)
  (org-mark-ring-push)
  (jk/agenda-refile "~/supervisor/supervisor.org" (car (jk/select-project ())))
  (org-mark-ring-goto)
  (org-agenda-redo-all)
  )

(defun jk/buffer-sort  ()
  (interactive)
  (org-mark-ring-push)
  (jk/buffer-refile "~/supervisor/supervisor.org" (car (jk/select-project ())))
  (org-mark-ring-goto)
  )

(defun jk/agenda-activate  ()
  (interactive)
  (org-agenda-todo "TODO")
  (org-agenda-schedule nil (org-read-date nil nil "+1d"))
  (org-mark-ring-push)
  (jk/agenda-refile "~/supervisor/supervisor.org" "Active")
  (org-mark-ring-goto)
  (org-agenda-redo-all)
  )

(defun jk/buffer-activate  ()
  (interactive)
  (org-todo "TODO")
  (org-schedule nil (org-read-date nil nil "+1d"))
  (org-mark-ring-push)
  (jk/buffer-refile "~/supervisor/supervisor.org" "Active")
  (org-mark-ring-goto)
  )

(defun jk/agenda-complete ()
  "Done, Move to completed.org"
  (interactive)
  (org-agenda-todo "DONE")
  (org-mark-ring-push)
  (jk/agenda-refile "~/supervisor/completed.org" "Week")
  (org-mark-ring-goto)
  (org-agenda-redo-all)
  )

(defun jk/buffer-complete ()
  "Done, Move to completed.org"
  (interactive)
  (org-todo "DONE")
  (org-mark-ring-push)
  (jk/buffer-refile "~/supervisor/completed.org" "Week")
  (org-mark-ring-goto)
  )

;; Capture
(setq org-capture-templates '(("c" "Inbox" entry (file "~/supervisor/inbox.org")
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