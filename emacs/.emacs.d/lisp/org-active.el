;; Active / daily productivity system

(setq org-log-done 'time
      org-tag-alist '()
      org-agenda-deadline-faces '((1.001 . error)
	                                (1.0 . org-warning)
	                                (0.5 . org-upcoming-deadline)
	                                (0.0 . org-upcoming-distant-deadline))
      )
