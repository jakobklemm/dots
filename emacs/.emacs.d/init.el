;; init.el

;; Global settings
(defgroup jk/config nil
  "Global settings and constants used all through out the config."
  )

(defcustom jk/org-base-dir "~/org/"
  "Base path for org-mode to find files."
  :type 'string
  :group 'jk/config
  )

;; https://github.com/mishamyrt/Lilex
(defcustom jk/font "JetBrains Mono"
  "What font to use, might get overwritten for special (local) cases."
  :type 'string
  :group 'jk/config
  )

(defconst jk/core-path (concat user-emacs-directory "core/")
  "Path to the custom modules of the config."
  )

(defvar jk/core-modules '(packages
                          settings
                          font
                          colors
                          modeline
                          util
                          windows
                          input
                          )
  "List of all currently active modules, get loaded at startup."
  )

(defconst jk/modules-path (concat user-emacs-directory "modules/")
  "Path to the custom modules of the config."
  )

(defvar jk/modules '(jk-site
                     jk-ivy
                     jk-evil
                     jk-leader
                     jk-git
                     jk-programming
                     jk-lsp
                     jk-rust
                     jk-spelling
                     jk-org
                     jk-ox
                     jk-latex
                     jk-roam
                     jk-margins
                     )
  "List of all currently active modules, get loaded at startup."
  )

(setq user-full-name "Jakob Klemm"
      user-mail-address "github@jeykey.net")

(add-to-list 'load-path jk/core-path)

(dolist (m jk/core-modules)
  (require m)
  )

(add-to-list 'load-path jk/modules-path)

(dolist (m jk/modules)
  (require m)
  )

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(setq gc-cons-threshold jk/original-gc)

;; Metrics
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s."
		     (emacs-init-time)
                     )))

(provide 'init)
