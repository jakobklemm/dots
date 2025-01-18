;; Completion

(use-package company
  :diminish company-mode
  :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)

  (company-idle-delay 0.1)

  (company-show-numbers t)
  :config
  (global-company-mode 1)
  )

(use-package company-box
  :if (display-graphic-p)
  :defines company-box-icons-all-the-icons
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-backends-colors nil)
  (company-box-doc-delay 0.1)
  (company-box-doc-frame-parameters '((internal-border-width . 1)
                                      (left-fringe . 3)
                                      (right-fringe . 3)))
  :config
  (when (require 'all-the-icons nil t)
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
          `((Unknown . ,(all-the-icons-material "find_in_page" :height 1.0 :v-adjust -0.2))
            (Text . ,(all-the-icons-faicon "text-width" :height 1.0 :v-adjust -0.02))
            (Method . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Function . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Constructor . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Field . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
            (Variable . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
            (Class . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
            (Interface . ,(all-the-icons-material "share" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
            (Module . ,(all-the-icons-material "view_module" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
            (Property . ,(all-the-icons-faicon "wrench" :height 1.0 :v-adjust -0.02))
            (Unit . ,(all-the-icons-material "settings_system_daydream" :height 1.0 :v-adjust -0.2))
            (Value . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
            (Enum . ,(all-the-icons-material "storage" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
            (Keyword . ,(all-the-icons-material "filter_center_focus" :height 1.0 :v-adjust -0.2))
            (Snippet . ,(all-the-icons-material "format_align_center" :height 1.0 :v-adjust -0.2))
            (Color . ,(all-the-icons-material "palette" :height 1.0 :v-adjust -0.2))
            (File . ,(all-the-icons-faicon "file-o" :height 1.0 :v-adjust -0.02))
            (Reference . ,(all-the-icons-material "collections_bookmark" :height 1.0 :v-adjust -0.2))
            (Folder . ,(all-the-icons-faicon "folder-open" :height 1.0 :v-adjust -0.02))
            (EnumMember . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2))
            (Constant . ,(all-the-icons-faicon "square-o" :height 1.0 :v-adjust -0.1))
            (Struct . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
            (Event . ,(all-the-icons-octicon "zap" :height 1.0 :v-adjust 0 :face 'all-the-icons-orange))
            (Operator . ,(all-the-icons-material "control_point" :height 1.0 :v-adjust -0.2))
            (TypeParameter . ,(all-the-icons-faicon "arrows" :height 1.0 :v-adjust -0.02))
            (Template . ,(all-the-icons-material "format_align_left" :height 1.0 :v-adjust -0.2)))
          company-box-icons-alist 'company-box-icons-all-the-icons)))

(use-package eldoc-box
  :hook
  ((rust-ts-mode . eldoc-box-hover-mode))
  )

(use-package smartparens
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap))
  )

;; LSP Mode
(use-package lspce
  ;; :quelpa (lspce :fetcher github :repo "zbelial/lspce" :files ("*"))
  :load-path "~/Downloads/lspce/"
  :ensure nil
  :init
  (let ((default-directory (file-name-directory (locate-library "lspce"))))
    (message "Entering %s" (pwd))
    (unless (or (file-exists-p "lspce-module.so")
                (file-exists-p "lspce-module.d")
                (file-exists-p "lspce-module.dll"))
      (shell-command "cargo build --release")
      (cond ((eq system-type 'gnu/linux)
             (progn (copy-file "target/release/liblspce_module.so"
                               "lspce-module.so" t)
                    (copy-file "target/release/liblspce_module.d"
                               "lspce-module.d" t)))
            ((eq system-type 'windows-nt)
             (progn (copy-file "target/release/lspce_module.dll"
                               "lspce-module.dll" t)
                    (copy-file "target/release/lspce_module.d"
                               "lspce-module.d" t))))
      (message "Done.")))
  (require 'lspce)
  :hook
  ((rust-ts-mode . lspce-mode))
  )

(use-package yasnippet
  :config
  (yas-global-mode t)
  )

(use-package yasnippet-snippets
  )


(define-minor-mode lspce-inlay-hints-mode
  ""
  :lighter nil
  (if lspce-inlay-hints-mode
      (setq lspce-inlay-hints-mode nil)
    (add-to-list 'after-change-functions 'lspce--after-change)
    )
  ;; (if lspce-inlay-hints-mode
  ;;     (progn
  ;; 	(lspce--clear-overlays)
  ;; 	;; (when lspce-inlay-hints-timer
  ;; 	  ;; (cancel-timer lspce-inlay-hints-timer)
  ;; 	;;  )
  ;; 	)
  ;;   (if lspce-mode
  ;; 	(progn
  ;; 	  (jk/test-command)
  ;; 	  ;; (setq lspce-inlay-hints-timer (run-with-idle-timer 3 t 'jk/test-command))
  ;; 	  )
  ;;     (progn
  ;; 	(setq lspce-inlay-hints-mode nil)
  ;; 	(error "lspce stuff")
  ;; 	)
  ;;     )
  ;;   )
  )

(defun lspce--after-change (beg end before)
  "after"
  (when (lspce-inlay-hints-mode)
    (progn
      ;; Remove in updated region
      (save-restriction
	(widen)
	(remove-overlays beg end 'lspce-inlay-hint t)
	)
      (let ((resp (lspce--request "textDocument/inlayHint" (jk/make-inlayHintParams))))
	(dolist (elem resp)
	  (let* ((position (gethash "position" elem))
		 (label (gethash "label" elem))
		 (kind (gethash "kind" elem))
		 (textEdits (gethash "textEdits" elem))
		 (paddingLeft (gethash "paddingLeft" elem))
		 (paddingRight (gethash "paddingRight" elem))
		 (data (gethash "data" elem))
		 (pos (jk/get-pos position))
		 (abspos (jk/abs-pos pos))
		 (zone (jk/expand-to-lines beg end))
		 (beginning (car zone))
		 (ending (cdr zone))
		 )
	    (if (jk/should-update beginning ending abspos)
		(lspce--add-overlay abspos (jk/get-label-str label) kind paddingLeft paddingRight)
	      )
	    )
	  )
	)
      )
    )
  )

(defun jk/expand-to-lines (region_start region_end)
  "expand"
  (let ((beginning (save-excursion
		     (goto-char region_start)
		     (line-beginning-position)
		     ))
	(ending (save-excursion
		  (goto-char region_end)
		  (line-end-position)
		  ))
	)
    (cons beginning ending)
    )
  )

(defun jk/should-update (beg end abspos)
      "maybe"
      (let* (
	     (is_in_min (> abspos beg))
	     (is_in_max (< abspos end))
	     )
	(and is_in_min is_in_max)
	)
      )



;; (add-to-list 'after-change-functions 'lspce--after-change-test)

(defun jk/test-command ()
  "wrapper"
  (lspce--clear-overlays)
  (jk/test-command-redraw)
  )

(defun jk/test-command-redraw ()
  "test lspce command"
  (let* ((resp (lspce--request "textDocument/inlayHint" (jk/make-inlayHintParams)))
	 (scnd (cdr resp))
	 (first (car resp))
	 )
    (dolist (elem resp)
      (let* ((position (gethash "position" elem))
	     (label (gethash "label" elem))
	     (kind (gethash "kind" elem))
	     (textEdits (gethash "textEdits" elem))
	     (paddingLeft (gethash "paddingLeft" elem))
	     (paddingRight (gethash "paddingRight" elem))
	     (data (gethash "data" elem))
	     (pos (jk/get-pos position))
	     (abspos (jk/abs-pos pos))
	     )
	(lspce--add-overlay abspos (jk/get-label-str label) kind paddingLeft paddingRight)
	)
      )
    )
  )

(defun lspce--clear-overlays ()
  (save-restriction
    (widen)
    (remove-overlays (point-min) (point-max) 'lspce-inlay-hint t)
    )
  )

(defun lspce--add-overlay (abspos label kind padding-left padding-right)
  "create new overlay type hint"
  (let ((overlay (make-overlay abspos abspos nil 'front-advance 'end-advance)))
    (overlay-put overlay 'lspce-inlay-hint t)
    (overlay-put overlay 'before-string (format "%s%s%s"
						(if padding-left " " "")
						(propertize label 'font-lock-face 'shadow)
						(if padding-right " " "")))
    )
  )

(defun jk/get-label-str (label)
  "fucked to slighly less fucked"
  (cond ((stringp label) label)
	((consp label) (string-join
			(mapcar (lambda (part) (gethash "value" part)) label)
			)
	 ))
  )

(defun jk/abs-pos (pos)
  "pos translate"
  (save-excursion
    (goto-char (point-min))
    (forward-line (car pos))
    (move-to-column (cdr pos))
    (point)
    )
  )

(defun jk/get-pos (pos)
  "pos stuff"
  (cons (gethash "line" pos) (gethash "character" pos))
  )

(defun jk/make-inlayHintParams ()
  "make parameters -> lspce 310."
  (let* ((params (make-hash-table))
	 (region (lspce--region-bounds))
	 (beg (nth 0 region))
	 (end (nth 1 region)))
    (puthash :textDocument (lspce--textDocumentIdenfitier (lspce--path-to-uri buffer-file-name)) params)
    ;; (puthash :range (lspce--make-range beg end) params)
    (puthash :range (jk/make-range) params)
    params))

(defun jk/make-range ()
  (let ((params (make-hash-table)))
    (puthash :start (jk/make-range-start) params)
    (puthash :end (jk/make-range-end) params)
    params))

(defun jk/make-range-start ()
  (let ((params (make-hash-table)))
    (puthash :line (line-number-at-pos (window-start)) params)
    (puthash :character 0 params)
    params))

(defun jk/make-range-end ()
  (let ((params (make-hash-table)))
    (puthash :line (min (+ (line-number-at-pos (window-end)) 1) (count-lines (point-min) (point-max))) params)
    (puthash :character 0 params)
    params))

(provide 'completion)
