;; Navigation

(use-package ace-window
  :init
  (setq aw-scope 'frame
	    aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)
	    )
  )

(defun hrs/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  (consult-buffer)
  )

(defun hrs/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  (consult-buffer)
  )

(use-package consult
  :config
  (consult-preview-at-point-mode)
 ) 

(use-package vertico
  :init
  (vertico-mode)
  (vertico-reverse-mode)
  :custom
  ((enable-recursive-minibuffers t))
  )

(use-package orderless
  :init
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil ;;'((file (styles partial-completion)))))
	)
  )

(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode)
  )

(use-package marginalia
  :config
  (marginalia-mode))

;; TODO: Embark

(use-package corfu
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect-first nil)    ;; Disable candidate preselection
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  (corfu-scroll-margin 5)        ;; Use scroll margin
  (tab-always-indent 'complete)

  :init
  (global-corfu-mode)
  )

(use-package corfu-doc
  :after corfu 
  :hook
  (corfu-mode . corfu-doc-mode)
  )

(use-package ripgrep)

(custom-set-variables
 '(mini-frame-show-parameters
   '((top . 0)
     (width . 0.5)
     (left . 0.5)
     )))

(use-package mini-frame
  :config
  (mini-frame-mode)
  )

(use-package savehist
  :init
  (savehist-mode)
  )

(use-package smooth-scrolling
  :custom 
  (
   (smooth-scroll-margin 12)
   )
  :config
  (smooth-scrolling-mode t)
  )

(provide 'navigation)
