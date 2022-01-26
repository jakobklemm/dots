;; Entry point for the emacs config. The actual config is in
;; =config.org= and evaluated here.

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(load-file (concat user-emacs-directory "lisp/setup.el"))
(load-file (concat user-emacs-directory "lisp/packages.el"))
(load-file (concat user-emacs-directory "lisp/core.el"))
(load-file (concat user-emacs-directory "lisp/design.el"))
(load-file (concat user-emacs-directory "lisp/navigation.el"))
(load-file (concat user-emacs-directory "lisp/org.el"))
(load-file (concat user-emacs-directory "lisp/programming.el"))
(load-file (concat user-emacs-directory "lisp/com.el"))
(load-file (concat user-emacs-directory "lisp/modes.el"))
(load-file (concat user-emacs-directory "lisp/misc.el"))
(load-file (concat user-emacs-directory "lisp/binds.el"))
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(setq gc-cons-threshold 1000000)

