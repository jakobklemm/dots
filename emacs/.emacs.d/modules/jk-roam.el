;; Roam

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
				  :if-new (file+head "main/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE:"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
                 ("e" "ETH" plain
				  "%?"
				  :if-new (file+head "eth/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
                 ("d" "Docs" plain
				  "%?"
				  :if-new (file+head "docs/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
                 ("o" "Output" plain
				  "%?"
				  :if-new (file+head "out/%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: \n#+DATE: "
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
				 ("r" "Reference" plain
				  "%?"
				  :if-new (file+head "references/%<%Y%m%d>.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :reference:\n"
						     )
				  :immediate-finish t
				  :unnarrowed t
				  )
				 ("c" "Capture" plain
				  "%?"
				  :if-new (file+head "%<%Y%m%d>-${slug}.org"
						     "#+TITLE: ${title}\n#+FILETAGS: :capture:\n"
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

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

(setq org-roam-node-display-template
      (concat "${type:10} - ${tags:30}: ${title:*}"))

(defun jk/get-specific-random-discmath ()
    "get discmath node"
    (interactive)
    (org-roam-node-random nil 'jk/org-roam-is-discmath)
    )

(defun jk/get-specific-random-and ()
    "get and node"
    (interactive)
    (org-roam-node-random nil 'jk/org-roam-is-and)
    )

(defun jk/get-specific-random-linalg ()
    "get linalg node"
    (interactive)
    (org-roam-node-random nil 'jk/org-roam-is-linalg)
    )

(defun jk/get-specific-random-eprog ()
    "get discmath node"
    (interactive)
    (org-roam-node-random nil 'jk/org-roam-is-eprog)
    )

(defun jk/org-roam-is-discmath (node)
  "Is the node tagged as discmath"
  (member "discmath" (org-roam-node-tags node))
  )

(defun jk/org-roam-is-and (node)
  "Is the node tagged as discmath"
  (member "and" (org-roam-node-tags node))
  )

(defun jk/org-roam-is-linalg (node)
  "Is the node tagged as discmath"
  (member "linalg" (org-roam-node-tags node))
  )

(defun jk/org-roam-is-eprog (node)
  "Is the node tagged as discmath"
  (member "eprog" (org-roam-node-tags node))
  )

(use-package org-roam-ui
  :after org-roam
  :custom
  ((org-roam-ui-sync-theme t)
   (org-roam-ui-follow t)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))

(use-package org-roam-timestamps
  :config
  (setq org-roam-timestamps-remember-timestamps t)
  (setq org-roam-timestamps-minimum-gap 3600)
  )

(use-package org-ref)

(use-package org-caldav
  :custom
  ((org-caldav-url "https://cloud.jeykey.net/remote.php/dav/calendars/jeykey/")
   (org-caldav-calendar-id "events")
   (org-caldav-inbox "~/org/active/ref.org")
   (org-caldav-files '())
   (org-caldav-timezone "Europe/Berlin")
   )
  )

(provide 'jk-roam)
