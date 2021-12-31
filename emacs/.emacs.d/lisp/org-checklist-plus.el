;; Custom functions for checklist templates. Currently just a
;; simplified version, will have to be extended in the future.

(defun jk/insert-checklist ()
  "Insert checklist from template"
  (interactive)
  (insert-file-contents (read-file-name "Select template:" "~/supervisor/checklists/"))
  )

(defun jk/from-file (path)
  (insert-file-contents path)
  )

(require 'org-mouse)
(add-to-list 'org-modules 'org-mouse t)
