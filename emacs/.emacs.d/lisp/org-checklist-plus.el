;; Custom functions for checklist templates. Currently just a
;; simplified version, will have to be extended in the future.

(defun jk/insert-checklist ()
  "Insert checklist from template"
  (interactive)
  (insert-file-contents (read-file-name "Select template:" "~/supervisor/checklists/"))
  )

(defun jk/open-checklist ()
  "Insert checklist from template"
  (interactive)
  (counsel-find-file nil "~/supervisor/checklists/")
  )

(require 'org-mouse)
(add-to-list 'org-modules 'org-mouse t)

(global-set-key (kbd "C-c C-c") 'jk/insert-checklist)
(global-set-key (kbd "C-c C-n") 'jk/open-checklist)
