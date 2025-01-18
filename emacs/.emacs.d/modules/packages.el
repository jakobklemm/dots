;; Packges

(require 'package)

(when (version< "29.0.50" emacs-version)
  (setq package-native-compile t
	warning-minimum-level :emergency))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(package-initialize)

(require 'use-package)

(use-package use-package
  :custom
  ((use-package-always-ensure t)
   (use-package-compute-statistics t)))

(use-package quelpa-use-package
  :custom
  ((quelpa-checkout-melpa-p nil)))


(provide 'packages)
