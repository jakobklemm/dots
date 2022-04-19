;; Navigation

(use-package ibuffer
  :defer t
  :bind (("C-x C-b" . ibuffer))
  :init
  (add-hook 'ibuffer-mode-hook #'hl-line-mode))

(use-package popper
  :defer t
  :bind (("C-;"   . popper-toggle-latest)
         ("M-;"   . popper-cycle)
         ("C-M-;" . popper-toggle-type))
  :custom
  ((popper-reference-buffers
    '("\\*Messages\\*"
      "Output\\*$"
      "\\*Async Shell Command\\*"
      help-mode
      compilation-mode)))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package counsel
  :defer t
  :diminish ivy-mode counsel-mode
  :defines
  (projectile-completion-system magit-completing-read-function)
  :preface
  (defun ivy-format-function-pretty (cands)
    "Transform CANDS into a string for minibuffer."
    (ivy--format-function-generic
     (lambda (str)
       (concat
        (all-the-icons-faicon "hand-o-right" :height .85 :v-adjust .05 :face 'font-lock-constant-face)
        (ivy--add-face str 'ivy-current-match)))
     (lambda (str)
       (concat "  " str))
     cands
     "\n"))
  :hook
  (after-init . ivy-mode)
  (ivy-mode . counsel-mode)
  :custom
  (counsel-yank-pop-height 15)
  (enable-recursive-minibuffers t)
  (ivy-use-selectable-prompt t)
  (ivy-use-virtual-buffers t)
  (ivy-on-del-error-function nil)
  (swiper-action-recenter t)
  (counsel-grep-base-command "ag -S --noheading --nocolor --nofilename --numbers '%s' %s")
  (enable-recursive-minibuffers t)
  (search-default-mode #'char-fold-to-regexp)
  (ivy-posframe-height-alist '((swiper . 20)
				               (t      . 15)))
  )

(use-package ivy
  :defer t
  :bind (
         ("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("M-y" . counsel-yank-pop)
         ("C-x b" . ivy-switch-buffer)
         ("C-c l" . counsel-git-log)
         )
  :config
  (use-package ivy-rich
    :defer t
    :after ivy
    :custom ((setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))
    )
  (use-package amx
    :defer t
    :after ivy
    :custom
    ((amx-backend 'auto)
     (amx-save-file "~/.emacs.d/etc/amx-items")
     (amx-history-length 50)
     (amx-show-key-bindings nil))
    )
  (use-package all-the-icons-ivy-rich
    :defer t
    :after ivy
    )
  (use-package swiper
    :defer t
    )
  (use-package ivy-posframe
    :defer t
    :after ivy
    :custom
    ((ivy-posframe-parameters
	  '((left-fringe . 4)
	    (right-fringe . 4)))
     (ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
	 (ivy-posframe-border-width 2)
     (ivy-wrap t)
     )
    :custom-face
    (ivy-posframe ((t (:background "#292735" :foreground "#f0f0f0"))))
    (ivy-posframe-border ((t (:background "#212026"))))
    (ivy-posframe-cursor ((t (:background "#e456e9"))))
    :hook
    (ivy-mode . ivy-posframe-mode)
    )
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-immediate-done)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-backward-delete-char)
  (ivy-mode 1)
  (ivy-rich-mode 1)
  (amx-mode 1)
  (all-the-icons-ivy-rich-mode 1)
  (ivy-posframe-mode 1)
  )

(use-package ace-window
  :defer t
  :init
  (setq aw-scope 'frame ; limit to single frame
	    aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)
	    )
  )

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

(global-set-key [next] 'scroll-up-half)
(global-set-key [prior] 'scroll-down-half)
(global-set-key (kbd "M-n") 'scroll-up-half)
(global-set-key (kbd "M-p") 'scroll-down-half)
