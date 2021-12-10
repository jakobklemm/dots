(defun dw/minibuffer-backward-kill (arg)
  "When minibuffer is completing a file name delete up to parent
                              folder, otherwise delete a word"
  (interactive "p")
  (if minibuffer-completing-file-name
      (if (string-match-p "/." (minibuffer-contents))
          (zap-up-to-char (- arg) ?/)
        (delete-minibuffer-contents))
    (backward-kill-word arg)))

(use-package vertico
  :defer t
  :custom-face
  (vertico-current ((t (:background "#3a3f5a"))))
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("C-l" . dw/minibuffer-backward-kill))
  :custom
  ((vertico-cycle t))
  :init
  (vertico-mode)
  :config
  (define-key vertico-map "?" #'minibuffer-completion-help)
  (define-key vertico-map (kbd "M-RET") #'minibuffer-force-complete-and-exit)
  (define-key vertico-map (kbd "M-TAB") #'minibuffer-complete)
  )

(use-package corfu
  :defer t
  :bind (:map corfu-map
              ("C-j" . corfu-next)
              ("C-k" . corfu-previous)
              ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  :config
  (corfu-global-mode))

(use-package orderless
  :defer t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles .
						      (partial-completion))))))

(use-package savehist
  :defer t
  :init
  (savehist-mode)
  )

(use-package consult
  :defer t
  :bind (("C-s" . consult-line)
         ("M-s" . consult-imenu)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :config
  (consult-preview-at-point-mode)
  )

(use-package marginalia
  :defer t
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode)
  )

(use-package bufler
  :defer t
  :config
  (bufler-mode)
  )

(use-package mini-frame
  :config
  (custom-set-variables
   '(mini-frame-show-parameters
     '((top . 0.4)
       (width . 0.5)
       (left . 0.5))))
  (mini-frame-mode t)
  )

;; Ace window for easy window navigation
(use-package ace-window
  :defer t
  :init
  (setq aw-scope 'frame ; limit to single frame
        aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n))
  )

;; https://github.com/hrs/dotfiles
(defun hrs/split-window-below-and-switch ()
    "Split the window horizontally, then switch to the new pane."
    (interactive)
    (split-window-below)
    (balance-windows)
    (other-window 1)
    (bufler-switch-buffer)
    )

  (defun hrs/split-window-right-and-switch ()
    "Split the window vertically, then switch to the new pane."
    (interactive)
    (split-window-right)
    (balance-windows)
    (other-window 1)
    (bufler-switch-buffer)
    )

(global-set-key (kbd "C-x 2") 'hrs/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'hrs/split-window-right-and-switch)

(defun hrs/rename-file (new-name)
  (interactive "FNew name: ")
  (let ((filename (buffer-file-name)))
    (if filename
        (progn
          (when (buffer-modified-p)
            (save-buffer))
          (rename-file filename new-name t)
          (kill-buffer (current-buffer))
          (find-file new-name)
          (message "Renamed '%s' -> '%s'" filename new-name))
      (message "Buffer '%s' isn't backed by a file!" (buffer-name)))))
