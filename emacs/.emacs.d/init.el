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
(defcustom jk/font "Lilex"
  "What font to use, might get overwritten for special (local) cases."
  :type 'string
  :group 'jk/config
  )

(defconst jk/core-path (concat user-emacs-directory "core/")
  "Path to the custom modules of the config."
  )

(defvar jk/core-modules '(packages
			  setup
			  design
			  font
			  windows
			  )
  "List of all currently active core functions, get loaded at startup."
  )

(defconst jk/modules-path (concat user-emacs-directory "modules/")
  "Path to the custom modules of the config."
  )

(defvar jk/modules '(
		     jk-git
		     jk-navigation
		     jk-selection
		     jk-binds
		     jk-editor
		     jk-writing
		     jk-site
                     )
  "List of all currently active modules, get loaded at startup."
  )

(defconst jk/modes-path (concat user-emacs-directory "modes/")
  "Path to the custom modes of the config."
  )

(defvar jk/modes '(
		   jk-org
		   jk-rust
		   jk-lua
		   jk-python
                   )
  "List of all currently active modes, get loaded at startup."
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

(add-to-list 'load-path jk/modes-path)

(dolist (m jk/modes)
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
