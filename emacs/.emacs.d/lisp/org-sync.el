;; Sync with Baikal server

(require 'auth-source)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))

(use-package org-caldav
  :config
  (setq org-caldav-url "https://caldav.jeykey.net/dav.php/calendars/jeykey/")
  (setq org-caldav-calendar-id "jeykey-personal")
  (setq org-caldav-inbox "~/supervisor/inbox.org")
  (setq org-caldav-files '("~/supervisor/active.org" "~/supervisor/events.org"))
  (setq org-icalendar-timezone "Europe/Berlin")
  )
