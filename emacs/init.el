;; Entry point for the emacs config.
;; The actual config is in =config.org= and evaluated here.

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)
