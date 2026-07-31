;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jakob Klemm"
      user-mail-address "github@jeykey.net"
      doom-font "Monaspace Argon"

      display-line-numbers-type t
      display-line-numbers-type 'relative
      org-directory "~/org/"
      delete-by-moving-to-trash t
      window-combination-resize t
      x-stretch-cursor t
      undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      truncate-string-ellipsis "…"
      password-cache-expiry nil
      scroll-margin 2
      display-time-default-load-average nil
      which-key-idld 0.5
      evil-vsplit-window-right t
      evil-split-window-below t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t
      +zen-text-scale 1.2
      +zen-mixed-pitch-modes '()
      org-agenda-files (list org-directory)
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-fold-catch-invisible-edits 'smart
      org-image-actual-width '(0.9)
      org-ellipsis " ▾ "
      org-hide-leading-stars t
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue))
      scroll-preserve-screen-position 'always
      scroll-margin 12
      scroll-preserve-screen-position t
      doom-modeline-enable-word-count t
      org-todo-keywords '((sequence "TODO(t)" "BLOCKED(b)" "GEN(g)"
               "|"
               "DONE(d/!)" "SEP(s@/!)"))
      )

;; https://emacsredux.com/blog/2026/04/07/stealing-from-the-best-emacs-configs/
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
(setq redisplay-skip-fontification-on-input t)
(setq read-process-output-max (* 4 1024 1024))
(setq save-interprogram-paste-before-kill t)
(setq kill-do-not-save-duplicates t)
(setq window-combination-resize t)

(display-time-mode 1)
(global-subword-mode 1)

(load-theme 'everforest-hard-dark t)


(setq doom-theme 'everforest-hard-dark
      ;; doom-theme 'modus-operandi
      ;; doom-theme 'doom-rose-pine-moon
      ;; catppuccin-flavor 'frappe
      ;; catppuccin-flavor 'frappe
      ;; doom-theme 'catppuccin
      ;; doom-theme 'doom-henna
      ;; doom-theme 'doom-rose-pine-dawn
      )

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(use-package! vertico
        :init
        (vertico-mode)
        :config
        (setq vertico-cycle t
        vertico-resize nil
        vertico-count 17)

        (require 'vertico-directory)
        (require 'vertico-quick)
        (require 'vertico-repeat)
        (require 'vertico-buffer)

        (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

        (define-key vertico-map "\M-q" #'vertico-quick-insert)
        (define-key vertico-map "\C-q" #'vertico-quick-exit)

        (define-key vertico-map "\C-n" #'vertico-next)
        (define-key vertico-map "\C-p" #'vertico-previous)

        (define-key vertico-map (kbd "C-<return>") #'vertico-exit-input)

        (add-hook 'minibuffer-setup-hook #'vertico-repeat-save))

(use-package! orderless
        :custom
        (completion-styles '(orderless basic))
        (completion-category-defaults nil)
        (completion-category-overrides '((file (styles partial-completion orderless))
                                        (buffer (styles orderless))
                                        (project-file (styles orderless))))
        :config
        (setq orderless-matching-styles
        '(orderless-literal
                orderless-prefixes
                orderless-initialism
                orderless-regexp))

        (setq orderless-smart-case t)
        )

(use-package! marginalia
        :init
        (marginalia-mode)
        :config
        (setq marginalia-align 'right
        marginalia-align-offset -1)

        (map! :map minibuffer-local-map
        "M-A" #'marginalia-cycle))

(use-package! consult
        :config
        (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

        (advice-add #'register-preview :override #'consult-register-window)

        (setq consult-narrow-key "<"
        consult-line-numbers-widen t
        consult-async-min-input 2
        consult-async-refresh-delay 0.15
        consult-async-input-throttle 0.2
        consult-async-input-debounce 0.1
        consult-preview-key 'any)

        (setq consult-project-function (lambda (_) (projectile-project-root)))

        (map! :leader
        :prefix "s"
        :desc "Search line" "l" #'consult-line
        :desc "Search line (multi)" "L" #'consult-line-multi
        :desc "Search outline" "o" #'consult-outline
        )

        (map! :leader
        :prefix "b"
        :desc "Switch buffer" "b" #'consult-buffer
        )
        )

(use-package! corfu
        :custom
        (corfu-cycle t)
        (corfu-auto t)
        (corfu-auto-delay 0.2)
        (corfu-auto-prefix 2)
        (corfu-quit-at-boundary 'separator)
        (corfu-quit-no-match 'separator)
        (corfu-preview-current nil)
        (corfu-preselect 'prompt)
        (corfu-scroll-margin 5)
        :init
        (global-corfu-mode)
        :config
        ;; Enable Corfu in the minibuffer (useful for eval expressions)
        (defun corfu-enable-in-minibuffer ()
        "Enable Corfu in the minibuffer if Vertico is not active."
        (when (not (bound-and-true-p vertico--input))
        (setq-local corfu-auto nil)
        (corfu-mode 1)))
        (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

        (map! :map corfu-map
        "TAB" #'corfu-next
        [tab] #'corfu-next
        "S-TAB" #'corfu-previous
        [backtab] #'corfu-previous
        "RET" #'corfu-insert
        [return] #'corfu-insert))

(use-package! cape
        :config
        (add-to-list 'completion-at-point-functions #'cape-dabbrev)
        (add-to-list 'completion-at-point-functions #'cape-file)
        (add-to-list 'completion-at-point-functions #'cape-keyword))

(map!
        :leader
        "/" #'+default/search-buffer
        "SPC" #'consult-buffer
        "r" #'consult-recent-file)

(map!
        :leader
        :prefix ("f" . "file")
        "g" #'consult-ripgrep)

(use-package! jinx
        :init
        (setq jinx-languages "en_US de_CH")
        :config
        (add-hook 'text-mode-hook #'jinx-mode)
        (add-hook 'conf-mode-hook #'jinx-mode)
        (add-hook 'prog-mode-hook #'jinx-mode)

        (map! :leader
        :prefix "s"
        :desc "Correct word at point" "c" #'jinx-correct
        :desc "Correct nearest" "n" #'jinx-correct-nearest
        :desc "Show corrections" "s" #'jinx-correct-all
        ))

(use-package! savehist
	  :init
	  (savehist-mode)
	  :config
	  (setq savehist-file "~/.doom.d/.savehist"
	        history-length 1000
	        history-delete-duplicates t
	        savehist-save-minibuffer-history t
	        savehist-additional-variables
	        '(kill-ring
	          search-ring
	          regexp-search-ring
	          last-kbd-macro
	          kmacro-ring
	          shell-command-history
	          register-alist))
	
	  (add-hook 'savehist-save-hook
	            (lambda ()
	              (setq buffer-file-coding-system 'utf-8-unix))))

(use-package! prescient
        :config
        (setq prescient-history-length 1000
        prescient-save-file "~/.doom.d/.prescient-save"
        prescient-filter-method '(literal regexp initialism fuzzy)
        prescient-sort-full-matches-first t)

        (defun prescient--save-with-utf8 (orig-fun &rest args)
                "Ensure prescient saves with UTF-8 encoding."
                (let ((coding-system-for-write 'utf-8-unix))
                (apply orig-fun args)))
        (advice-add 'prescient--save :around #'prescient--save-with-utf8)

        (prescient-persist-mode +1))

(use-package! vertico-prescient
        :after vertico
        :config
        (setq vertico-prescient-enable-filtering t
        vertico-prescient-enable-sorting t)
        (vertico-prescient-mode +1))

(use-package! corfu-prescient
        :after corfu
        :config
        (corfu-prescient-mode +1))
 	
(use-package! popper
        :init
        (setq popper-reference-buffers
        '("\\*Messages\\*"
                "Output\\*$"
                "\\*Async Shell Command\\*"
                "\\*Warnings\\*"
                "\\*compilation\\*"
                "\\*Completions\\*"
                "\\*Backtrace\\*"
                help-mode
                compilation-mode
                flycheck-error-list-mode
                occur-mode))

        :config
        (setq popper-display-control t)
        (setq popper-display-function #'popper-select-popup-at-bottom)

        (popper-mode +1)
        (popper-echo-mode +1)

        (global-set-key (kbd "C-,") #'popper-toggle)
        (global-set-key (kbd "C-.") #'popper-cycle)

        (after! org
	  (define-key org-mode-map (kbd "C-,") nil))
        )

(use-package! org
  :config
  (load! "~/.config/doom/org.el")
  )

;; https://emacs.stackexchange.com/questions/12122/how-to-access-os-clipboard-using-emacs-evil
(setq x-select-enable-clipboard nil)

(defun paste-from-clipboard ()
  (interactive)
  (setq x-select-enable-clipboard t)
  (yank)
  (setq x-select-enable-clipboard nil)
  )

(defun copy-to-clipboard()
  (interactive)
  (setq x-select-enable-clipboard t)
  (kill-ring-save (region-beginning) (region-end))
  (setq x-select-enable-clipboard nil)
  )

 	
(use-package! good-scroll
        :config
        (good-scroll-mode 1)
        )
