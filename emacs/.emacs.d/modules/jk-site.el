;; Personal website using org-publish

(require 'ox-publish)
(use-package htmlize)

(setq org-publish-project-alist
      (list
       (list "site"
             :recursive nil
             :base-directory "~/Documents/jeykey.net/content/"
             :with-author nil
             :with-creator nil
             :with-date t
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file t
             :section-numbers nil
             :auto-sitemap nil
             :sitemap-format-entry 'jk/build-entry
             :publishing-directory "~/Documents/jeykey.net/public/"
             :publishing-function 'org-html-publish-to-html
             )
       (list "blog"
	     :recursive t
             :base-directory "~/Documents/jeykey.net/content/posts/"
             :with-author nil
             :with-creator nil
             :with-date t
             :with-toc nil
             :with-section-numbers nil
             :time-stamp-file t
             :section-numbers nil
             :auto-sitemap t
             :sitemap-sort-files 'anti-chronologically
             :sitemap-title "Overview"
             :sitemap-filename "overview.html"
             :sitemap-date-format "%d.%m.%Y"
             :sitemap-format-entry 'jk/build-entry
	     :sitemap-function 'jk/build-sitemap
             :publishing-directory "~/Documents/jeykey.net/public/posts/"
             :publishing-function 'org-html-publish-to-html
	     )
       (list "static"
             :base-directory "~/Documents/jeykey.net/content/static/"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|asc"
             :publishing-directory "~/Documents/jeykey.net/public/static/"
             :publishing-function 'org-publish-attachment
             :recursive t)
       (list "style"
             :base-directory "~/Documents/jeykey.net/style/"
             :base-extension "css\\|js"
             :publishing-directory "~/Documents/jeykey.net/public/style/"
             :publishing-function 'org-publish-attachment
             :recursive t)
       ))

(defun jk/build-entry (a b c)
  "Defines format of sitemap entries."
  (format "- %s: [[file:%s][%s]]" (format-time-string "%d.%m.%Y" (org-publish-find-date a c)) a (org-publish-find-title a c))
  )

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-html-head "
<meta name=\"author\" content=\"Jakob Klemm\">
<link rel=\"stylesheet\" href=\"/style/style.css\" />
<h1><a href=\"/\">Jakob Klemm</a></h1>
<div class=\"hdr\">
<a href=\"/posts/overview.html\">Overview</a>
<a href=\"/about.html\">About</a>
<a href=\"https://github.com/jakobklemm/\">Github</a>
<a href=\"mailto:github@jeykey.net\">Contact</a>
</div>
<script>
  var _paq = window._paq = window._paq || [];
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u=\"//analytics.jeykey.net/\";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
")

(defun jk/publish-site ()
  (interactive)
  (delete-directory "~/documents/jeykey.net/public/" t)
  (org-publish-remove-all-timestamps)
  (org-publish-all t)
  )

;; https://djliden.github.io/posts/20211203-this-site.html
(defun jk/build-sitemap (title list)
   "Sitemap generation function."
   (concat "#+OPTIONS: toc:nil")
   (org-list-to-subtree list)
   )

(provide 'jk-site)
