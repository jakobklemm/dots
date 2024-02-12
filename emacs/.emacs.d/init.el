(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(org-babel-load-file "~/.emacs.d/config.org")

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s."
		     (emacs-init-time)
                     )))
