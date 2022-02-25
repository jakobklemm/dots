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
      '((sequence "TODO(t)" "PROGRESS(p)" "WAITING(w)" "EVENT(s)" "|" "DONE(d)" "SEP(s)"))
      org-todo-keyword-faces '(("TODO" . (:foreground "#af1212" :weight bold))
                               ("PROGRESS" . (:foreground "#A0FF9F" :weight bold))
                               ("WAITING" . (:foreground "#990099" :weight bold))
                               ("STATIC" . (:foreground "#F28722" :weight bold))
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
  (let* (
         (parsed jk/parse-file jk/projects-file)
         (selection
          (completing-read "Project: " jk/projects nil t)))
    (org-mark-ring-push)
    (jk/refile-to jk/projects-file selection)
    (org-mark-ring-goto)))

(defun jk/refile-to-ideas ()
  (interactive)
  (jk/parse-file jk/ideas-file jk/ideas)
  (let ((selection
         (completing-read "Topic: " jk/ideas nil t)))
    (org-mark-ring-push)
    (jk/refile-to jk/ideas-file selection)
    (org-mark-ring-goto)))

(defun jk/refile-to-events ()
  "Move current headline to bookmarks"
  (interactive)
  (org-mark-ring-push)
  (jk/refile-to jk/events-file "")
  (org-mark-ring-goto))

(defun jk/test ()
  (interactive)
  (setq jk-test (jk/parse-file jk/projects-file))
  )

;; Utilities
;; Execute code in org with [[elisp:(jk/test-function)][name]]
(setq org-link-elisp-skip-confirm-regexp "jk")

(setq jk/projects '(""))
(setq jk/ideas '(""))
(setq jk/projects-file "~/supervisor/projects.org")
(setq jk/ideas-file "~/supervisor/ideas.org")
(setq jk/quotes-file "~/supervisor/quotes.org")
(setq jk/events-file "~/supervisor/events.org")

(defun jk/parse-file (path)
  (with-temp-buffer
    (insert-file-contents path)
    (jk/parse-buffer)
    )
  )

(require 'cl)

(defun jk/parse-buffer ()
  (interactive)
  (let ((store '("")))
    (org-element-map (org-element-parse-buffer) 'headline
      (lambda (hl)
        (if (= (org-element-property :level hl) 1)
            (add-to-list store (format "%s" (org-element-property :raw-value hl)))
          )
        )
      (cl-return-from jk/parse-buffer store)
      )
    )
  )
