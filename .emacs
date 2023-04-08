(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(backup-directory-alist '(("." . "~/emacs-backups")))
 '(cua-enable-cua-keys nil)
 '(cua-enable-modeline-indications t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(tango-dark))
 '(default-input-method "TeX")
 '(delete-selection-mode t)
 '(dired-x-hands-off-my-keys nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(embark rg orderless marginalia vertico dired-toggle which-key hydra auctex all-the-icons unicode-math-input latex-unicode-math-mode unicode-math-mode projectile-ag projectile-ripgrep counsel-tramp counsel-projectile amx all-the-icons-ivy-rich-mode which-key-posframe ivy-posframe company-posframe posframe diminish all-the-icons-ivy all-the-icons-ivy-rich company-quickhelp company-math company-auctex company color-moccur org-download magit kpm-list ivy-rich ivy-hydra counsel tuareg use-package))
 '(recentf-mode t)
 '(rg-command-line-flags '("--hidden"))
 '(safe-local-variable-values '((org-export-html-postamble)))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(use-package-compute-statistics t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-nick-default-face ((t nil)))
 '(highlight ((t (:background "olive drab" :foreground "#2e3436"))))
 '(region ((t (:extend t :background "AntiqueWhite2")))))

(add-to-list 'load-path
	     "~/lisp")



;; more packages from melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


(when t
  ;; Enable vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :bind
  (:map vertico-map
         ("C-v" . vertico-scroll-up)
         ("M-v" . vertico-scroll-down))  
  :config
  ;; the first four of these  don't work for binding but the last two do. use :bind
  ;; above instead
  ;; (define-key vertico-map [remap scroll-up-command] 'vertico-scroll-up) 
  ;; (define-key vertico-map [remap scroll-down-command] 'vertico-scroll-down)
  ;; (define-key vertico-map [remap cua-scroll-up] 'vertico-scroll-up)
  ;; (define-key vertico-map [remap cua-scroll-down] 'vertico-scroll-down)
  ;; (define-key vertico-map (kbd "C-v") 'vertico-scroll-up) 
  ;; (define-key vertico-map (kbd "M-v") 'vertico-scroll-down) 


  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
;;  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package rg)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (setq completion-category-defaults  nil))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
);;when t

(unless nil

  (use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;; (use-package all-the-icons-ivy
;;   :ensure t
;;   :disabled t
;;   :after (all-the-icons ivy)
;;   :custom (all-the-icons-ivy-buffer-commands '(ivy-switch-buffer-other-window))
;;   :config
;;   (add-to-list 'all-the-icons-ivy-file-commands 'counsel-dired-jump)
;;   (add-to-list 'all-the-icons-ivy-file-commands 'counsel-find-library)
;;   (all-the-icons-ivy-setup))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

;; (use-package amx
;;   :ensure t)

;; (use-package auctex
;;   :ensure t
;;   :demand t
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

(use-package color-moccur
  :ensure t
  :commands (isearch-moccur isearch-all isearch-moccur-all)
  :bind (("M-s O" . moccur)
         :map isearch-mode-map
         ("M-o" . isearch-moccur)
         ("M-O" . isearch-moccur-all)))

;; (use-package company
;;   :ensure t
;;   :defer 5
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
;;   :ensure t
;;   :after (company latex auctex))

;; (use-package company-math
;;   :ensure t
;;   :after company
;;   :defer t)

;; (use-package company-posframe
;;   :ensure t
;;   :after (company posframe))

;; (use-package company-quickhelp
;;   :ensure t
;;   :after company
;;   :bind (:map company-active-map
;;               ("C-c ?" . company-quickhelp-manual-begin)))

;; (use-package counsel
;;   :ensure t
;;   :after ivy
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
;;   :ensure t
;;   :after (counsel projectile)
;;   :config
;;   (counsel-projectile-mode 1))

;; (use-package counsel-tramp
;;   :ensure t
;;   :commands counsel-tramp)

(use-package diminish
  :ensure t
  :demand t)

;; (use-package dired-toggle
;;   :ensure t
;;   :disabled t
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
;;   :ensure t)

;; (use-package ivy
;;   :ensure t
;;   :diminish
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
;;   :ensure t
;;   :after (ivy hydra)
;;   :defer t)

;; (use-package ivy-posframe
;;   :ensure t
;;   :after (ivy posframe))

;; (use-package ivy-rich
;;   :ensure t
;;   :after ivy
;;   :demand t
;;   :config
;;   (ivy-rich-mode 1)
;;   (setq ivy-virtual-abbreviate 'full
;;         ivy-rich-switch-buffer-align-virtual-buffer t
;;         ivy-rich-path-style 'abbrev))

(use-package kpm-list
  :ensure t
  :bind (("C-x C-b" . kpm-list)))

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
;;   :ensure t)

;; (use-package latex-unicode-math-mode
;;   :ensure t
;;   :config
;;   :commands (latex-unicode-mode
;; 	     latex-unicode-math-mode
;; 	     latex-unicode-convert-region latex-unicode-convert-buffer
;; 	     latex-unicode-invert-region latex-unicode-invert-buffer))

(use-package magit
  :defer t
  :ensure t)

(use-package matm-opam
  :load-path "lisp"
  :hook (tuareg-load . opam-setup)
  )
;; (use-package opam-user-setup
;;    :load-path ".emacs.d" 
;;    :hook (tuareg-mode ocp-setup-indent)) 

;; (use-package org-download
;;   :defer t
;;   :ensure t)

(use-package personal
  :load-path "lisp"
  :config
  (setq ring-bell-function 'my-bell-function)
  (fset 'yes-or-no-p 'y-or-n-p)
  ;; (add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)
  :bind (("C-c u" . switch-math-input-method)
         ("C-c M-q" . unfill-paragraph)
	 :map comint-mode-map
	 ("C-c M-o" . comint-clear-buffer)))


;; (use-package posframe
;;   :ensure t
;;   :config
;;   (require 'posframe))

;; (use-package projectile
;;   :ensure t
;;   :defer 5
;;   :diminish
;;   :bind* (("C-c TAB" . projectile-find-other-file)
;;           ("C-c P" . (lambda () (interactive)
;;                        (projectile-cleanup-known-projects)
;;                        (projectile-discover-projects-in-search-path))))
;;   :bind-keymap ("C-c p" . projectile-command-map)
;;   :config
;;   (projectile-global-mode)

;;   (defun my-projectile-invalidate-cache (&rest _args)
;;     ;; We ignore the args to `magit-checkout'.
;;     (projectile-invalidate-cache nil))

;;   (eval-after-load 'magit-branch
;;     '(progn
;;        (advice-add 'magit-checkout
;;                    :after #'my-projectile-invalidate-cache)
;;        (advice-add 'magit-branch-and-checkout
;;                    :after #'my-projectile-invalidate-cache))))

;; (use-package projectile-ripgrep
;;   :ensure t
;;   :after projectile)

;; (use-package swiper
;;   :disabled
;;   :diminish
;;   :after ivy
;;   :bind (("C-s" . swiper)))

(use-package tuareg
  :ensure t)

(use-package unicode-math-input
  :ensure t)


(use-package which-key
  :ensure t
  :defer 5
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode))

;; (use-package which-key-posframe
;;   :ensure t
;;   :after (which-key posframe))

(server-start)
);;unless t


