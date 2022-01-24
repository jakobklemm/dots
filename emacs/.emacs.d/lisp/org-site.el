;; Personal website

(require 'ox-publish)
(use-package htmlize)

(setq org-publish-project-alist
      (list
       (list "jeykey.net"
             :recursive t
             :base-directory "~/documents/jeykey.net/content"
             :with-author nil
             :with-creator nil
             :with-date t
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file nil
             :section-numbers nil
             :auto-sitemap t
             :sitemap-sort-files 'anti-chronologically
             :sitemap-file-entry-format "%t - %d "
             :sitemap-filename "sitemap.org"
             :sitemap-title "Sitemap"
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

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      ;; <link rel=\"stylesheet\" href=\"style/style.css\" />
      org-html-head "
<meta name=\"author\" content=\"Jakob Klemm\">
<link href=\"http://thomasf.github.io/solarized-css/solarized-dark.min.css\" rel=\"stylesheet\"></link>
<h1><a href=\"/\">Jakob Klemm</a></h1>
<div class=\"hdr\">
<a href=\"https://github.com/jakobklemm\" target=\"_blank\">Github</a>
<a href=\"sitemap.html\">Sitemap</a>
<a href=\"static/public.asc\">PGP Key</a>
<a href=\"mailto:github@jeykey.net\">github@jeykey.net</a>
</div>
")

(defun jk/publish-site ()
  (interactive)
  (delete-directory "~/documents/jeykey.net/public/" t)
  (org-publish-remove-all-timestamps)
  (org-publish-all t)
  )
