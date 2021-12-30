(use-package org-roam
  :defer t
  :init
  (setq org-roam-directory "~/documents/braindump/")
  (setq org-roam-v2-ack t)
  (setq org-roam-completion-everywhere t)
  :custom
  ((org-roam-capture-templates
    '(("d" "default" plain
       "%?"
       :if-new (file+head "${slug}.org"
                          "#+TITLE: ${title}\n\n")
       :immediate-finish t
       :unnarrowed t))))
  :config
  (org-roam-db-autosync-mode)
  )

(use-package org-roam-ui
  :defer t
  :after org-roam
  :custom
  ((org-roam-ui-sync-theme t)
   (org-roam-ui-follow t)
   (org-roam-ui-update-on-save t)
   (org-roam-ui-open-on-start nil)
   ))

