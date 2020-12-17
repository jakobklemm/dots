(setq user-full-name "Jakob Klemm"
      user-mail-address "jakob@jeykey.net"
      )

;; All code added by "custom" is stored in "custom.el"
(setq custom-file "~/.emacs.d/custom.el")
(load-file "~/.emacs.d/custom.el")


;; Auto save related settings
(setq auto-save-file-name-transforms
          `((".*" ,(concat user-emacs-directory "auto-save/") t))) 