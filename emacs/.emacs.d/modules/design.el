;; Design

(use-package doom-themes
  :config
  (load-theme 'doom-palenight t)
  )

(use-package catppuccin-theme
  :config
  ;; (setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
  ;; (catppuccin-reload)
  )

(use-package doom-modeline
  :config
  (doom-modeline-mode)
  )


(use-package minions
  :hook (doom-modeline-mode . minions-mode))

;; https://github.com/hrs/dotfiles
(setq hrs/default-fixed-font "JetBrains Mono")
(setq hrs/default-fixed-font-size 120)
(setq hrs/current-fixed-font-size hrs/default-fixed-font-size)
(set-face-attribute 'default nil
                    :family hrs/default-fixed-font
                    :height hrs/current-fixed-font-size)
(set-face-attribute 'fixed-pitch nil
                    :family hrs/default-fixed-font
                    :height hrs/current-fixed-font-size)
(setq hrs/font-change-increment 1.1)

(defun hrs/set-font-size ()
  "Change default, fixed-pitch, and variable-pitch font sizes to match respective variables."
  (set-face-attribute 'default nil
		              :height hrs/current-fixed-font-size)
  (set-face-attribute 'fixed-pitch nil
		              :height hrs/current-fixed-font-size)
  )

(defun hrs/reset-font-size ()
  "Revert font sizes back to defaults."
  (interactive)
  (setq hrs/current-fixed-font-size hrs/default-fixed-font-size)
  (hrs/set-font-size))

(defun hrs/increase-font-size ()
  "Increase current font sizes by a factor of `hrs/font-change-increment'."
  (interactive)
  (setq hrs/current-fixed-font-size
        (ceiling (* hrs/current-fixed-font-size hrs/font-change-increment)))
  (hrs/set-font-size))

(defun hrs/decrease-font-size ()
  "Decrease current font sizes by a factor of `hrs/font-change-increment', down to a minimum size of 1."
  (interactive)
  (setq hrs/current-fixed-font-size
        (max 1
             (floor (/ hrs/current-fixed-font-size hrs/font-change-increment))))
  (hrs/set-font-size))

(define-key global-map (kbd "C-)") 'hrs/reset-font-size)
(define-key global-map (kbd "C-+") 'hrs/increase-font-size)
(define-key global-map (kbd "C-=") 'hrs/increase-font-size)
(define-key global-map (kbd "C-_") 'hrs/decrease-font-size)
(define-key global-map (kbd "C--") 'hrs/decrease-font-size)

(hrs/reset-font-size)

(use-package rainbow-delimiters
  :hook
  ((org-mode . rainbow-delimiters-mode)
   (prog-mode . rainbow-delimiters-mode)))


(use-package all-the-icons
  :if (window-system))

(provide 'design)
