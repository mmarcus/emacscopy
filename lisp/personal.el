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
(defun comint-clear-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

;; let's bind the new command to a keycombo
(define-key comint-mode-map "\C-c\M-o" #'comint-clear-buffer)


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

;; stop beeping when mouse scroll out of range
(defun my-bell-function ()
  (unless (memq this-command
		'(isearch-abort abort-recursive-edit exit-minibuffer
				keyboard-quit mwheel-scroll down up next-line previous-line
				backward-char forward-char))
    (ding)))


(provide 'personal)

