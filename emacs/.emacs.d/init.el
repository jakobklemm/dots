;; Entry point for the emacs config. The actual config is in
;; =config.org= and evaluated here.

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Initial settings, disable some emacs features.
(load-file (concat user-emacs-directory "lisp/setup.el"))

;; Package installers
(load-file (concat user-emacs-directory "lisp/packages.el"))

;; Basic packages, util stuff.
(load-file (concat user-emacs-directory "lisp/core.el"))

;; Theme & Colors
(load-file (concat user-emacs-directory "lisp/design.el"))

;; Moving between files, buffers and frames
(load-file (concat user-emacs-directory "lisp/navigation.el"))

;; org-mode & writing
(load-file (concat user-emacs-directory "lisp/org.el"))

;; Git, Programming & Modes
(load-file (concat user-emacs-directory "lisp/programming.el"))

;; Keybinds, evil-like stuff
(load-file (concat user-emacs-directory "lisp/binds.el"))

;; Email
(load-file (concat user-emacs-directory "lisp/com.el"))
;; Any custom stuff
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(setq gc-cons-threshold 1000000)
