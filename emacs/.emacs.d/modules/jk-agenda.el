;; Agenda

(setq org-icalendar-include-todo 'all
      org-caldav-sync-todo t
      )

(use-package auth-source
  )

(use-package org-caldav
  :custom
  ((org-caldav-url "https://cloud.jeykey.net/remote.php/dav/calendars/jeykey/")
   (org-caldav-calendar-id "tasks")
   (org-caldav-inbox "~/org/active.org")
   (org-caldav-files '("~/org/archive/2023.org"))
   (org-caldav-timezone "Europe/Berlin")
   )
  )

(provide 'agenda)
