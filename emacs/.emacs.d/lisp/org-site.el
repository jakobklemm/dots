;; Legacy website (reference)

(require 'ox-publish)
(use-package htmlize)

(setq org-publish-project-alist
      (list
       (list "jeykey.net"
             :recursive t
             :base-directory "~/documents/jeykey.net/content/"
             :with-author nil
             :with-creator nil
             :with-date t
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file t
             :section-numbers nil
             :auto-sitemap t
             :sitemap-sort-files 'chronologically
             :sitemap-title "Overview"
             :sitemap-filename "overview.html"
             :sitemap-date-format "%d.%m.%Y"
             :sitemap-format-entry 'jk/build-entry
             :publishing-directory "~/documents/jeykey.net/public/"
             :publishing-function 'org-html-publish-to-html
             )
       (list "static"
             :base-directory "~/documents/jeykey.net/content/static/"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|asc"
             :publishing-directory "~/documents/jeykey.net/public/static/"
             :publishing-function 'org-publish-attachment
             :recursive t)
       (list "style"
             :base-directory "~/documents/jeykey.net/style/"
             :base-extension "css\\|js"
             :publishing-directory "~/documents/jeykey.net/public/style/"
             :publishing-function 'org-publish-attachment
             :recursive t)
       ))

(defun jk/build-entry (a b c)
  ""
  ;; (format-time-string "%d.%m.%Y" (time-convert (org-publish-find-date a c) 'integer) t)
  ;; (format "%s" (time-convert (org-publish-find-date a c) 'integer) t)
  ""
  )

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-html-head "
<meta name=\"author\" content=\"Jakob Klemm\">
<link rel=\"stylesheet\" href=\"style/style.css\" />
<h1><a href=\"/\">Jakob Klemm</a></h1>
<div class=\"hdr\">
<a href=\"https://github.com/jakobklemm/\">Github</a>
<a href=\"mailto:github@jeykey.net\">Contact</a>
</div>
")

(defun jk/publish-site ()
  (interactive)
  (delete-directory "~/documents/jeykey.net/public/" t)
  (org-publish-remove-all-timestamps)
  (org-publish-all t)
  )
