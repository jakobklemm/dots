;; Init

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(defconst jk/modules-path (expand-file-name "modules/" user-emacs-directory)
  "Path to the custom modules of the config."
  )

(add-to-list 'load-path jk/modules-path)

(defconst jk/modules '(packages
		       defaults
		       design
		       navigation
		       completion
		       programming
		       writing
		       binds
		       )
  "List of all currently active stuff, get loaded at startup."
  )

(dolist (m jk/modules)
  (require m)
  )

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s."
		     (emacs-init-time)
                     )))
