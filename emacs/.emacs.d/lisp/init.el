(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Initial settings, disable some emacs features.
(load-file (concat user-emacs-directory "modules/setup.el"))
(load-file (concat user-emacs-directory "modules/packages.el"))
(load-file (concat user-emacs-directory "modules/core.el"))
(load-file (concat user-emacs-directory "modules/design.el"))
(load-file (concat user-emacs-directory "modules/navigation.el"))
(load-file (concat user-emacs-directory "modules/org.el"))
(load-file (concat user-emacs-directory "modules/programming.el"))
(load-file (concat user-emacs-directory "modules/evil.el"))
;; Any custom stuff
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(setq gc-cons-threshold 1000000)
