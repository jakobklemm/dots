;; Productivity

;; Capute templates
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
  (jk/refile-to jk/quotes-file "")
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
  (let ((content '()))
    (push (with-temp-buffer
            (insert-file-contents (format "~/documents/templates/habits/%s" (format-time-string "%u")))
            (buffer-string))
          content)
    (push (with-temp-buffer
            (insert-file-contents "~/documents/templates/generic.org")
            (buffer-string))
          content)
    (write-region (mapconcat #'identity content "") nil (concat "~/supervisor/" "active.org"))
    )
  )

;; Utilities
;; Execute code in org with [[elisp:(jk/test-function)][name]]
(setq org-link-elisp-skip-confirm-regexp "jk")

(setq jk/projects '(""))
(setq jk/projects-file "~/supervisor/projects.org")
(setq jk/ideas-file "~/supervisor/ideas.org")
(setq jk/quotes-file "~/supervisor/quotes.org")
(setq jk/events-file "~/supervisor/events.org")

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
