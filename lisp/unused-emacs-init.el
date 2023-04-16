;; (use-package amx
;;   )

;; (use-package auctex
;;   ;;   :demand t
;;   :no-require t
;;   :mode ("\\.tex\\'" . TeX-latex-mode)
;;   :config
;;   (defun latex-help-get-cmd-alist ()    ;corrected version:
;;     "Scoop up the commands in the index of the latex info manual.
;;    The values are saved in `latex-help-cmd-alist' for speed."
;;     ;; mm, does it contain any cached entries
;;     (if (not (assoc "\\begin" latex-help-cmd-alist))
;;         (save-window-excursion
;;           (setq latex-help-cmd-alist nil)
;;           (Info-goto-node (concat latex-help-file "Command Index"))
;;           (goto-char (point-max))
;;           (while (re-search-backward "^\\* \\(.+\\): *\\(.+\\)\\." nil t)
;;             (let ((key (buffer-substring (match-beginning 1) (match-end 1)))
;;                   (value (buffer-substring (match-beginning 2)
;;                                            (match-end 2))))
;;               (add-to-list 'latex-help-cmd-alist (cons key value))))))
;;     latex-help-cmd-alist))

;; (use-package company
;;   ;;   :defer 5
;; 					;  :diminish
;;   :commands (company-mode company-indent-or-complete-common)
;;   :init
;;   (dolist (hook '(emacs-lisp-mode-hook
;;                   c-mode-common-hook))
;;     (add-hook hook
;;               #'(lambda ()
;;                   (local-set-key (kbd "<tab>")
;;                                  #'company-indent-or-complete-common))))
;;   :config
;;   ;; From https://github.com/company-mode/company-mode/issues/87
;;   ;; See also https://github.com/company-mode/company-mode/issues/123
;;   (defadvice company-pseudo-tooltip-unless-just-one-frontend
;;       (around only-show-tooltip-when-invoked activate)
;;     (when (company-explicit-action-p)
;;       ad-do-it))

;;   ;; See http://oremacs.com/2017/12/27/company-numbers/
;;   (defun ora-company-number ()
;;     "Forward to `company-complete-number'.
;;   Unless the number is potentially part of the candidate.
;;   In that case, insert the number."
;;     (interactive)
;;     (let* ((k (this-command-keys))
;;            (re (concat "^" company-prefix k)))
;;       (if (cl-find-if (lambda (s) (string-match re s))
;;                       company-candidates)
;;           (self-insert-command 1)
;;         (company-complete-number (string-to-number k)))))

;;   (let ((map company-active-map))
;;     (mapc
;;      (lambda (x)
;;        (define-key map (format "%d" x) 'ora-company-number))
;;      (number-sequence 0 9))
;;     (define-key map " " (lambda ()
;;                           (interactive)
;;                           (company-abort)
;;                           (self-insert-command 1))))

;;   (defun check-expansion ()
;;     (save-excursion
;;       (if (outline-on-heading-p t)
;;           nil
;;         (if (looking-at "\\_>") t
;;           (backward-char 1)
;;           (if (looking-at "\\.") t
;;             (backward-char 1)
;;             (if (looking-at "->") t nil))))))

;;   (define-key company-mode-map [tab]
;;     '(menu-item "maybe-company-expand" nil
;;                 :filter (lambda (&optional _)
;;                           (when (check-expansion)
;;                             #'company-complete-common))))

;;   ;; (eval-after-load "coq"
;;   ;;   '(progn
;;   ;;      (defun company-mode/backend-with-yas (backend)
;;   ;;        (if (and (listp backend) (member 'company-yasnippet backend))
;;   ;;            backend
;;   ;;          (append (if (consp backend) backend (list backend))
;;   ;;                  '(:with company-yasnippet))))
;;   ;;      (setq company-backends
;;   ;;            (mapcar #'company-mode/backend-with-yas company-backends))))

;;   (global-company-mode 1))

;; (use-package company-auctex
;;   ;;   :after (company latex auctex))

;; (use-package company-math
;;   ;;   :after company
;;   :defer t)

;; (use-package company-posframe
;;   ;;   :after (company posframe))

;; (use-package company-quickhelp
;;   ;;   :after company
;;   :bind (:map company-active-map
;;               ("C-c ?" . company-quickhelp-manual-begin)))


;; (use-package counsel
;;   ;;   :after ivy
;;   :demand t
;;   :diminish
;;   :bind (("C-*"     . counsel-org-agenda-headlines)
;; 	 ("C-x C-f" . counsel-find-file)
;; 	 ("C-c e l" . counsel-find-library)
;;          ("C-c e q" . counsel-set-variable)
;; 	 ("C-c e u" . counsel-unicode-char)
;; 	 ("C-h f"   . counsel-describe-function)
;; 	 ("C-x r b" . counsel-bookmark)
;; 	 ("M-x"     . counsel-M-x)
;; 	 ))

;; (use-package counsel-projectile
;;   ;;   :after (counsel projectile)
;;   :config
;;   (counsel-projectile-mode 1))

;; (use-package counsel-tramp
;;   ;;   :commands counsel-tramp)

;; (use-package dired-toggle
;;   ;;   :disabled
;;   :bind (("s-<f3>" . #'dired-toggle)
;;          :map dired-mode-map
;;          ("q" . #'dired-toggle-quit)
;;          ([remap dired-find-file] . #'dired-toggle-find-file)
;;          ([remap dired-up-directory] . #'dired-toggle-up-directory)
;;          ("C-c C-u" . #'dired-toggle-up-directory))
;;   :config
;;   (setq dired-toggle-window-size 32)
;;   (setq dired-toggle-window-side 'left)

;;   ;; Optional, enable =visual-line-mode= for our narrow dired buffer:
;;   (add-hook 'dired-toggle-mode-hook
;;             (lambda () (interactive)
;;               (visual-line-mode 1)
;;               (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))
;;               (setq-local word-wrap nil))))


;; (use-package dired-x
;;   :after dired
;;   :custom
;;   (function (lambda ()
;;                       ;; Bind dired-x-find-file.
;;                       (setq dired-x-hands-off-my-keys nil)
;;                       (load "dired-x")
;;                       )))


;; (use-package hydra
;;   )

;; (use-package ivy
;;   ;;   :diminish
;;   :demand t

;;   :bind (("C-x b" . ivy-switch-buffer)
;;          ("C-x B" . ivy-switch-buffer-other-window))

;;   ;; :bind (:map ivy-minibuffer-map
;;   ;;             ("<tab>" . ivy-alt-done)
;;   ;;             ("SPC"   . ivy-alt-done-or-space)
;;   ;;             ("C-d"   . ivy-done-or-delete-char)
;;   ;;             ("C-i"   . ivy-partial-or-done)
;;   ;;             ("C-r"   . ivy-previous-line-or-history)
;;   ;;             ("M-r"   . ivy-reverse-i-search))

;;   ;; :bind (:map ivy-switch-buffer-map
;;   ;;             ("C-k" . ivy-switch-buffer-kill))
;;   :config
;;   (setq ivy-re-builders-alist
;; 	'((ivy-switch-buffer . ivy--regex-ignore-order)
;;           (swiper-isearch . ivy--regex-ignore-order)
;;           (t . ivy--regex-ignore-order)))
;;   :custom
;;   (ivy-dynamic-exhibit-delay-ms 200)
;;   ;; (ivy-height 10)
;;   ;; (ivy-initial-inputs-alist nil t)
;;   ;; (ivy-magic-tilde nil)
;;   (ivy-use-virtual-buffers t)
;;   (ivy-wrap t)
;;   (ivy-count-format "(%d/%d) ")

;;   :config
;;   (ivy-mode 1))

;; (use-package ivy-hydra
;;   :diminish
;;   ;;   :after (ivy hydra)
;;   :defer t)

;; (use-package ivy-posframe
;;   ;;   :after (ivy posframe))

;; (use-package ivy-rich
;;   ;;   :after ivy
;;   :demand t
;;   :config
;;   (ivy-rich-mode 1)
;;   (setq ivy-virtual-abbreviate 'full
;;         ivy-rich-switch-buffer-align-virtual-buffer t
;;         ivy-rich-path-style 'abbrev))


;; (use-package latex
;;   :disabled
;;   :config
;;   (require 'preview)
;;   ;; (load (emacs-path "site-lisp/auctex/style/minted"))

;;   (info-lookup-add-help :mode 'LaTeX-mode
;;                         :regexp ".*"
;;                         :parse-rule "\\\\?[a-zA-Z]+\\|\\\\[^a-zA-Z]"
;;                         :doc-spec '(("(latex2e)Concept Index")
;;                                     ("(latex2e)Command Index")))

;;   (defvar latex-prettify-symbols-alist
;;     '(("\N{THIN SPACE}" . ?\⟷)))

;;   (bind-key "C-x SPC"
;;             #'(lambda ()
;;                 (interactive)
;;                 (insert "\N{THIN SPACE}"))
;;             LaTeX-mode-map)
;;   (bind-key "C-x A"
;;             #'(lambda ()
;;                 (interactive)
;;                 (insert "ٰ"))
;;             LaTeX-mode-map)
;;   (bind-key "A-َ"
;;             #'(lambda ()
;;                 (interactive)
;;                 (insert "ٰ"))
;;             LaTeX-mode-map)
;;   (bind-key "A-ه"
;;             #'(lambda ()
;;                 (interactive)
;;                 (insert "ۀ"))
;;             LaTeX-mode-map)
;;   (bind-key "A-د"
;;             #'(lambda ()
;;                 (interactive)
;;                 (insert "ذ"))
;;             LaTeX-mode-map)

;;   (add-hook 'LaTeX-mode-hook
;;             #'(lambda
;;                 ()
;;                 (setq-local prettify-symbols-alist latex-prettify-symbols-alist)
;;                 (prettify-symbols-mode 1))))

;; (use-package latex-math-preview
;;   :disabled
;;   )

;; (use-package latex-unicode-math-mode
;;   ;;   :config
;;   :commands (latex-unicode-mode
;; 	     latex-unicode-math-mode
;; 	     latex-unicode-convert-region latex-unicode-convert-buffer
;; 	     latex-unicode-invert-region latex-unicode-invert-buffer))

(use-package lsp-mode
  :disabled
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (tuareg-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp lsp-deferred)

(use-package lsp-treemacs :after lsp-mode :commands lsp-treemacs-errors-list)
(use-package lsp-ui :after lsp-mode :commands lsp-ui-mode)


;; (use-package posframe                      
;;   :config                                  
;;   (require 'posframe))                     


;; (use-package swiper
;;   :disabled
;;   :diminish
;;   :after ivy
;;   :bind (("C-s" . swiper)))

;; (use-package which-key-posframe
;;   ;;   :after (which-key posframe))

;; (use-package all-the-icons-ivy
;;   ;;   :disabled
;;   :after (all-the-icons ivy)
;;   :custom (all-the-icons-ivy-buffer-commands '(ivy-switch-buffer-other-window))
;;   :config
;;   (add-to-list 'all-the-icons-ivy-file-commands 'counsel-dired-jump)
;;   (add-to-list 'all-the-icons-ivy-file-commands 'counsel-find-library)
;;   (all-the-icons-ivy-setup))




(use-package all-the-icons-ivy-rich
  :disabled
  :init (all-the-icons-ivy-rich-mode 1))


(use-package color-moccur
  :disabled
  :commands (isearch-moccur isearch-all isearch-moccur-all)
  :bind (("M-s O" . moccur)
         :map isearch-mode-map
         ("M-o" . isearch-moccur)
         ("M-O" . isearch-moccur-all)))
