;; stop beeping when mouse scroll out of range
(defun my-bell-function ()
  (unless (memq this-command
		'(isearch-abort exit-minibuffer
				keyboard-quit mwheel-scroll down up next-line previous-line
				backward-char forward-char))
    (ding)))

;;abandon command when leave minibuffer
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))


;; for some reason comint mode doesn't offer a way to clear all
;; never mind, it does seem to in emacs 29
;; (defun comint-clear-buffer ()
;;   (interactive)
;;   (let ((comint-buffer-maximum-size 0))
;;     (comint-truncate-buffer)))

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil t)))

 (defun unicode-math-help ()
     (interactive)
     (find-file-other-window "~/unicode-math.txt"))

(defun switch-math-input-method ()
  (interactive)
  (if (equal current-input-method "TeX")
    (set-input-method "unicode-math")
  (set-input-method "TeX")))



(defun consult-buffer-other-tab ()
  "Variant of `consult-buffer' which opens in other tab."
  (interactive)
  (let ((consult--buffer-display #'switch-to-buffer-other-tab))
    (consult-buffer)))

;; (defun consult-find-file-other-tab (filename &optional wildcards)
;;   "Variant of `consult-find-file' which opens in other tab."
;;   (let ((consult--buffer-display #'switch-to-buffer-other-tab))
;;     (consult-buffer)))

  
;; (defun find-file-read-only-other-tab (filename &optional wildcards)
;;   "Edit file FILENAME, in another tab, but don't allow changes.
;; Like \\[find-file-other-frame] (which see), but creates a new tab.
;; Like \\[find-file-other-tab], but marks buffer as read-only.
;; Use \\[read-only-mode] to permit editing.
;; Interactively, prompt for FILENAME.
;; If WILDCARDS is non-nil, FILENAME can include widcards, and all matching
;; files will be visited."
;;   (interactive
;;    (find-file-read-args "Find file read-only in other tab: "
;;                         (confirm-nonexistent-file-or-buffer)))
;;   (find-file--read-only (lambda (filename wildcards)
;;                           (window-buffer
;;                            (find-file-other-tab filename wildcards)))
;;                         filename wildcards))




(provide 'personal)

