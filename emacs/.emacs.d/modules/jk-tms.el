;; Task Management System

(setq org-roam-dailies-directory "daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "%?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+TITLE: %<%Y-%m-%d>\n#+FILETAGS: \n"))))

(use-package org-incoming
  :custom
  (
   org-incoming-dirs '(
                       (:source "~/files/source/" :target "~/org/database/references/" :use-roam 't :pdf-subdir "references" :annotation-template "~/org/templates/incoming.org" )
                       )
   )
  )

(defun jk/add-to-daily ()
  (interactive)
  (setq jk-title (cadar (org-collect-keywords '("TITLE"))))
  (setq jk-path (buffer-file-name))
  (save-excursion
    (org-roam-dailies-goto-today)
    (goto-char (point-max))
    (insert (concat "\n* TODO " jk-title "\n [[file: " jk-path "]] \n"))
    (save-buffer)
    )
  )

(provide 'jk-tms)
