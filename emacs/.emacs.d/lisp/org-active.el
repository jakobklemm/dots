;; Active / daily productivity system

(setq org-capture-templates
      '(("t" "Todo" entry (file "~/supervisor/inbox.org")
         "* TODO %?\n%T\n%a")
        ))

(add-hook 'org-capture-mode-hook 'jk/toggle-mode)

(defun jk/toggle-mode ()
  (interactive)
  (setq modalka-mode nil)
  )

(setq org-log-done 'time
      org-todo-keywords '((sequence "TODO(t)" "PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "SEP(s)"))
      org-todo-keyword-faces '(("TODO" . (:foreground "#af1212" :weight bold))
                               ("PROGRESS" . (:foreground "#FAA022" :weight bold))
                               ("WAITING" . (:foreground "#990099" :weight bold))
                               ("DONE" . (:foreground "#ffffff" :weight bold))
                               ("SEP" . (:foreground "#474A44" :weight bold))
                               )
      org-tag-alist '()
      org-agenda-deadline-faces '((1.001 . error)
	                                (1.0 . org-warning)
	                                (0.5 . org-upcoming-deadline)
	                                (0.0 . org-upcoming-distant-deadline))
      )

(use-package org-journal
  :defer t
  :custom
  ((org-journal-dir "~/supervisor/journal/")
   (org-journal-file-type 'daily)
   (org-journal-date-format "%Y-%m-%d, %A")
   (org-journal-file-format "%Y%m%d.org")
   (org-journal-time-prefix "* ")
   (org-journal-date-prefix "#+TITLE: ")
   (org-journal-enable-agenda-integration t)
   (org-journal-carryover-items "")
   )
  )

