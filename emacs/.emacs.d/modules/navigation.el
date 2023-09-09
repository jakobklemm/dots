;; Navigation

;; https://config.daviwil.com/emacs

(use-package savehist
  :config
  (setq history-length 25)
  (savehist-mode 1))

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

  ;; Individual history elements can be configured separately
  ;;(put 'minibuffer-history 'history-length 25)
  ;;(put 'evil-ex-history 'history-length 50)
  ;;(put 'kill-ring 'history-length 25))

(defun dw/minibuffer-backward-kill (arg)
  "When minibuffer is completing a file name delete up to parent
folder, otherwise delete a word"
  (interactive "p")
  (if minibuffer-completing-file-name
      ;; Borrowed from https://github.com/raxod502/selectrum/issues/498#issuecomment-803283608
      (if (string-match-p "/." (minibuffer-contents))
          (zap-up-to-char (- arg) ?/)
        (delete-minibuffer-contents))
      (backward-kill-word arg)))

(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . dw/minibuffer-backward-kill))
  :custom
  (vertico-cycle t)
  :custom-face
  (vertico-current ((t (:background "#3a3f5a"))))
  :init
  (vertico-mode))

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package mini-frame
  :config
  (mini-frame-mode t)
  :custom
  (mini-frame-show-parameters
   '((top . 0.4)
     (width . 0.5)
     (left . 0.5)
     (height . 25)))
  )

(use-package ace-window
  :init
  (setq aw-scope 'frame
	aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)))

(global-set-key (kbd "C-x o") 'ace-window)

(use-package transpose-frame
  )

(defun hrs/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  (ido-switch-buffer)
  )

(defun hrs/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  (ido-switch-buffer)
  )

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)


(use-package popper
  :bind (("C-,"   . popper-toggle-latest)
         ("M-,"   . popper-cycle)
         ("C-M-," . popper-toggle-type))
  :custom
  ((popper-reference-buffers
    '("\\*Messages\\*"
      "Output\\*$"
      "\\*Async Shell Command\\*"
      "\\*Backtrace\\*"
      help-mode
      compilation-mode)))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package helpful)

;; Search
(use-package consult
  :config
  (global-set-key (kbd "C-s") 'consult-line)
  (global-set-key (kbd "C-S") 'consult-line-multi)
  (global-set-key (kbd "M-s") 'consult-grep)
  (global-set-key (kbd "M-S") 'consult-ripgrep)
  )

(provide 'navigation)
