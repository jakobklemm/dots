;; Productivity

;; Capture templates
(setq org-capture-templates
      '(
        ("t" "Todo" entry (file "~/supervisor/inbox.org")
         "* TODO %?\n%T\n%a")
        ("q" "Quotes" entry (file "~/supervisor/quotes.org")
         "* %?\n%T\n%a")
        ("i" "Ideas" entry (file "~/supervisor/ideas.org")
         "* %?\n%T\n%a")
        ("e" "Events" entry (file "~/supervisor/events.org")
         "* TODO %?\n%T\n%a")
        )
      )
(add-hook 'org-capture-mode-hook 'jk/toggle-mode)
(defun jk/toggle-mode ()
  (interactive)
  (setq modalka-mode nil)
  (evil-mode)
  )

;; Todos
(setq org-todo-keywords
      '((sequence "TODO(t)" "PROGRESS(p)" "WAITING(w)" "STATIC(s)" "|" "DONE(d)" "SEP(e)"))
      org-todo-keyword-faces '(("TODO" . (:foreground "#af1212" :weight bold))
                               ("PROGRESS" . (:foreground "#A0FF9F" :weight bold))
                               ("WAITING" . (:foreground "#990099" :weight bold))
                               ("STATIC" . (:foreground "#B26722" :weight bold))
                               ("DONE" . (:foreground "#ffffff" :weight bold))
                               ("SEP" . (:foreground "#474A44" :weight bold))
                               )
      )

;; Refile
;; https://emacs.stackexchange.com/questions/8045/org-refile-to-a-known-fixed-location
(defun jk/refile-to (file headline)
  "Move current headline to specified location"
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos))))
(defun jk/refile-to-project ()
  (interactive)
  (jk/parse-projects-file)
  (let ((selection
         (completing-read "Project: " jk/projects nil t)))
    (org-mark-ring-push)
    (jk/refile-to jk/projects-file selection)
    (org-mark-ring-goto)))
(defun jk/refile-to-events ()
  (interactive)
  (org-mark-ring-push)
  (jk/refile-to jk/events-file "")
  (org-mark-ring-goto))
(defun jk/refile-to-quotes ()
  (interactive)
  (org-mark-ring-push)
  (jk/refile-to jk/quotes-file "")
  (org-mark-ring-goto))
(defun jk/refile-to-ideas ()
  (interactive)
  (org-mark-ring-push)
  (jk/refile-to jk/ideas-file "")
  (org-mark-ring-goto))
(defun jk/refile-to-active-tasks ()
  (interactive)
  (org-mark-ring-push)
  (jk/refile-to jk/active-file "Tasks")
  (org-mark-ring-goto))
(defun jk/refile-to-active-tasks ()
  (interactive)
  (org-mark-ring-push)
  (jk/refile-to jk/active-file "Events")
  (org-mark-ring-goto))

;; Active
(defun jk/generate-template ()
  (interactive)
  )
(defun jk/store-active ()
  (interactive)
  (let ((date (format "~/documents/completed/%s.org" (format-time-string "%F"))))
    (with-temp-buffer
      (insert-file-contents "~/supervisor/active.org")
      (write-region nil nil date)
      )
    )
  )
(defun jk/generate-active ()
  (interactive)
  (let* ((content '())
         (habit-base "~/documents/templates/habits/%s")
         (action-base "~/documents/templates/actions/%s")
         (habit-path (if (file-exists-p (format habit-base (format-time-string "%u")))
                         (format habit-base (format-time-string "%u"))
                       (format habit-base "default")))
         (action-path (if (file-exists-p (format action-base (format-time-string "%u")))
                          (format action-base (format-time-string "%u"))
                        (format action-base "default")))
         )
    (push (with-temp-buffer
            (insert-file-contents habit-path)
            (buffer-string))
          content)
    (push (with-temp-buffer
            (insert-file-contents action-path)
            (buffer-string))
          content)
    (push (with-temp-buffer
            (insert-file-contents "~/documents/templates/generic.org")
            (buffer-string))
          content)
    (write-region (mapconcat #'identity content "") nil jk/active-file)
    )
  (if (get-buffer "active.org")
      (switch-to-buffer "active.org")
    (find-file jk/active-file)
    )
  )

;; Utilities
;; Execute code in org with [[elisp:(jk/test-function)][name]]

(global-auto-revert-mode t)
(setq auto-revert-use-notify nil)
(setq org-startup-folded nil)

;; (add-to-list 'org-agenda-bulk-custom-functions '(?R jk/bulk-refile))
;; Cloned from org-agenda.el
(defun jk/bulk-refile (&optional arg)
  (interactive "P")
  (if (not org-agenda-bulk-marked-entries)
      (save-excursion (org-agenda-bulk-mark)))
  (dolist (m org-agenda-bulk-marked-entries)
    (unless (and (markerp m)
		         (marker-buffer m)
		         (buffer-live-p (marker-buffer m))
		         (marker-position m))
      (user-error "Marker %s for bulk command is invalid" m)))

  (setq cmd (lambda () (jk/refile-to-active-tasks)))
  (setq redo-at-end t)

  (dolist (e entries)
	(let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
	  (if (not pos)
		  (progn (message "Skipping removed entry at %s" e)
		         (cl-incf skipped))
	    (goto-char pos)
	    (let (org-loop-over-headlines-in-active-region) (funcall cmd))
	    ;; `post-command-hook' is not run yet.  We make sure any
	    ;; pending log note is processed.
	    (when org-log-setup (org-add-log-note))
	    (cl-incf processed))))
  (when redo-at-end (org-agenda-redo))
  (unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
  )

(setq org-refile-targets '(("~/supervisor/active.org" :maxlevel . 1)))
(setq org-link-elisp-skip-confirm-regexp "jk")
(setq org-reverse-note-order t)

(setq jk/projects '(""))
(setq jk/projects-file "~/supervisor/projects.org")
(setq jk/ideas-file "~/supervisor/ideas.org")
(setq jk/quotes-file "~/supervisor/quotes.org")
(setq jk/events-file "~/supervisor/events.org")
(setq jk/active-file "~/supervisor/active.org")

;; Warning: elisp sucks and returning things from fuctions is
;; impossible. this is not a /nice/ solution but it works.
;; This requires
(defun jk/parse-projects-file ()
  (with-temp-buffer
    (insert-file-contents jk/projects-file)
    (jk/parse-projects-buffer)))

(defun jk/parse-projects-buffer ()
  (interactive)
  (org-element-map (org-element-parse-buffer) 'headline
    (lambda (hl)
      (if (= (org-element-property :level hl) 1)
          (push (format "%s" (org-element-property :raw-value hl)) jk/projects)
        ))))

(defun jk/parse-test ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents "~/supervisor/projects.org")
    (org-element-map (org-element-parse-buffer) 'headline
      (lambda (hl)
        (if (= (org-element-property :level hl) 4)
            (message (format "%s" (org-element-property hl "id")))
          )
        )
      )
    )
  )
