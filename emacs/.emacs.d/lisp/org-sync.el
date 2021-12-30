;; Sync with Baikal server

(require 'auth-source)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))

(use-package org-caldav
  :defer t
  )

(setq org-icalendar-include-todo 'all
      org-caldav-sync-todo t)

(setq org-caldav-url "https://caldav.jeykey.net/dav.php/calendars/jeykey/")
(setq org-caldav-calendar-id "jeykey-personal")
(setq org-caldav-inbox "~/supervisor/events.org")
(setq org-icalendar-timezone "Europe/Berlin")
