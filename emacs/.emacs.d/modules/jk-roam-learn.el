
(require 'org-roam)
(require 'cl)

(defvar jk/roam-learn-overlays '()
  "List of all overlays that are applied by `jk-roam-learn'")

(defcustom jk/roam-registered-tags '()
  "List of tags that are used by `jk-roam-learn'")

(defun jk/roam-learn-node (node)
  "Learn a NODE. This will hide the buffer contents and only show the title of
the NODE. To reveal the node use `jk/roam-learn-reveal'."
  (interactive)
  (org-roam-node-visit node)
  (let ((dest-pos))
    (save-excursion
      (goto-char (point-min))
      (setq dest-pos (re-search-forward "#\\+\\(TITLE\\|Title\\|title\\):"
					nil t))
      (goto-char dest-pos)
      (next-line)
      (beginning-of-line)
      (let ((overlay (make-overlay (point) (point-max) (current-buffer))))
	(overlay-put overlay 'display "...")
	(push overlay jk/roam-learn-overlays)))
    (goto-char (1+ dest-pos))))

(defun jk/roam-learn-reveal ()
  "Remove the overlay from the current buffer."
  (interactive)
  (dolist (overlay jk/roam-learn-overlays)
    (when (string-equal (buffer-name (current-buffer))
			(buffer-name (overlay-buffer overlay)))
      (delete-overlay overlay)
      (message "Revealing..."))))

(defun jk/roam-learn-reveal-all ()
  "Remove all overlays that are currently applied by this package."
  (interactive)
  (unless jk/roam-learn-overlays
    (dolist (overlay dk/roam-learn-overlays)
      (delete-overlay overlay))))

(defun jk/roam-learn-select-random-node (nodes)
  "Take a random node from NODES and return it."
  (cdr (seq-random-elt (nodes))))

(defun jk/roam-learn-matches-tag (node tag)
  "Check if NODE has TAG as one of it's members."
  (member tag (org-roam-node-tags node)))

(defun jk/roam-learn-get-nodes-matching-tag (tag)
  (let ((nodes (org-roam-node-list))
	(nodes (cl-remove-if-not
		(lambda (node) (jk/roam-learn-matches-tag node tag)))))
    nodes))

(defun jk/roam-learn ()
  "Select a tag and learn a random node."
  (interactive)
  (let ((tag (completing-read "Tag: " jk/roam-registered-tags nil t))
	(nodes (jk/roam-learn-get-nodes-matching-tag tag))
	(result (jk/roam-learn-select-random-node nodes)))
    (jk/roam-learn-node result)))

(defun jk/roam-learn-random-by-tag (tag)
  "Visit a random node that has TAG."
  (let ((nodes (jk/roam-learn-get-nodes-matching-tag tag))
	(node (jk/roam-learn-select-random-node nodes)))
    (jk/roam-learn-node node)))

(provide 'jk-roam-learn)
