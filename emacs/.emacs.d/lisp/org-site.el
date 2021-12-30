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
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file nil
             :section-numbers nil
             :publishing-directory "~/documents/jeykey.net/public/"
             :publishing-function 'org-html-publish-to-html
             )
       (list "static"
             :base-directory "~/documents/jeykey.net/content/static"
             :base-extension "css\\|js\\|png\\|..."
             :publishing-directory "~/documents/jeykey.net/public/static/"
             :publishing-function 'org-publish-attachment
             :recursive t)))

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "
<link rel=\"stylesheet\" href=\"style.css\" />
<h1><a href=\"/\"> Jakob Klemm</a></h1>
")

(org-publish-remove-all-timestamps)
(setq org-src-fontify-natively t)
