;; init.el

;; Global settings
(defgroup jk/config nil
  "Global settings and constants used all through out the config."
  )

(defcustom jk/org-base-dir "~/org/"
  "Base path for org-mode to find files."
  :type 'sting
  :group 'jk/config
  )

;; https://github.com/mishamyrt/Lilex
(defcustom jk/font "Lilex"
  "What font to use, might get overwritten for special (local) cases."
  :type 'string
  :group 'jk/config
  )

(defconst jk/modules-path "~/.emacs.d/modules/"
  "Path to the custom modules of the config."
  )

(defvar jk/active-modules '(base binds navigation programming design writing site prod)
  "List of all currently active modules, get loaded at startup."
  )

(setq user-full-name "Jakob Klemm"
      user-mail-address "jakob@jeykey.net")

;; Package setup
(require 'package)

(when (version< "29.0.50" emacs-version)
  (setq package-native-compile t
	warning-minimum-level :emergency))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(while (not (package-installed-p 'use-package))
  (sleep-for 1))

(require 'use-package)

(use-package use-package
  :custom
  ((use-package-always-ensure t)
   (use-package-compute-statistics t)))

(use-package quelpa-use-package
  :custom
  ((quelpa-checkout-melpa-p nil)))

;; Modules
(add-to-list 'load-path jk/modules-path)

(dolist (m jk/active-modules)
  (require m)
  )

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; Metrics
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s."
		     (emacs-init-time)
                     )))

(provide 'init)

