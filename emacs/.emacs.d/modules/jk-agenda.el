;; Agenda & Sync

(use-package org-caldav
  :custom
  ((org-caldav-url "https://cloud.jeykey.net/remote.php/dav/calendars/jeykey/")
   (org-caldav-calendar-id "events")
   (org-caldav-inbox "~/org/active/ref.org")
   (org-caldav-files '())
   (org-caldav-timezone "Europe/Berlin")
   )
  )

(provide 'jk-agenda)
