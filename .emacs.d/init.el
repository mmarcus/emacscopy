


;;(add-to-list 'load-path "~/lisp")



;; more packages from melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(package-initialize) called anyway since  package-enable-at-startup is not disabled

(setq package-selected-packages
      '(;;use-package
	 ace-window
	 all-the-icons
	 cape
	 consult
	 consult-dir
	 ;;consult-project-extra
	 corfu
	 ;; consult-lsp ;;using eglot for now instead
	 consult-projectile
	 diminish
	 dune
	 ef-themes
	 ;;eglot ;;29 built-in
	 embark
	 embark-consult
	 expand-region
	 kpm-list
	 ;; lsp-treemacs ;;using eglot for now instead
	 ;; lsp-ui ;;using eglot for now instead
	 magit
	 marginalia
	 modus-themes
	 orderless
	 popper
	 projectile
	 projectile-ripgrep
	 rainbow-delimiters
	 rg
	 savehist
	 shackle
	 tuareg
	 treemacs
	 treemacs-projectile
	 unicode-math-input
	 vertico
	 which-key
	 ;;zenburn-theme
	 ))


;; Install packages with (package-install-selected-packages)

;; Remove packages with (package-autoremove)
;; If you want to automate that, maybe add them to your 'emacs-startup-hook'?

;;(eval-when-compile
;;  (require 'use-package))

;; A few more useful configurations...



(use-package ace-window
  :bind* ("M-o" . ace-window)
;;  :custom
;;  (aw-dispatch-when-more-than 6)
  ;;  (aw-scope 'frame)
  :config
  (advice-add 'aw--switch-buffer :override #'consult-buffer)
  )


(use-package all-the-icons
  :if (display-graphic-p))

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("M-p p" . completion-at-point) ;; capf
         ("M-p t" . complete-tag)        ;; etags
         ("M-p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("M-p h" . cape-history)
         ("M-p f" . cape-file)
         ("M-p k" . cape-keyword)
         ("M-p s" . cape-symbol)
         ("M-p a" . cape-abbrev)
         ("M-p l" . cape-line)
         ("M-p w" . cape-dict)
         ("M-p \\" . cape-tex)
         ("M-p _" . cape-tex)
         ("M-p ^" . cape-tex)
         ("M-p &" . cape-sgml)
         ("M-p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; NOTE: The order matters!
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  (add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package comint
  :config
  :bind (:map comint-mode-map)
  ("C-c M-o" . comint-clear-buffer))

(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ;; ("C-c M-x" . consult-mode-command)
         ;; ("C-c h" . consult-history)
         ;; ("C-c K" . consult-kmacro)
         ;; ("C-c i" . consult-info)
         ;; ([remap Info-search] . consult-info)

         ;; ("C-*"     . consult-org-heading)
         ;; ("C-c e l" . find-library)
         ;; ("C-c e q" . set-variable)
         ;; ("C-h e l" . find-library)

         ;; ("M-s f" . counsel-file-jump)
         ;; ;; ("M-s g" . counsel-rg)
         ;; ("M-s j" . counsel-dired-jump)

         ;; ;; C-x bindings (ctl-x-map)
         ("C-x M-ESC" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-org-heading)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         
	 )

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  ;; :hook (completion-list-mode . consult-preview-at-point-mode)

	 :custom
	 (consult-preview-key "M-.")
	 (consult-narrow-key "<")

  ;; :custom-face
  ;; (consult-file ((t (:inherit font-lock-string-face))))

  ;; The :init configuration is always executed (Not lazy)
  ;; :init

  ;; ;; Optionally configure the register formatting. This improves the register
  ;; ;; preview for `consult-register', `consult-register-load',
  ;; ;; `consult-register-store' and the Emacs built-ins.
  ;; (setq register-preview-delay 0.5
  ;;       register-preview-function #'consult-register-format)

  ;; ;; Optionally tweak the register preview window.
  ;; ;; This adds thin lines, sorting and hides the mode line of the window.
  ;; (advice-add #'register-preview :override #'consult-register-window)

  ;; ;; Use Consult to select xref locations with preview
	 (setq xref-show-xrefs-function #'consult-xref
               xref-show-definitions-function #'consult-xref)
	 (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
	 
  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  ;; :config

  ;; (consult-customize
  ;;  consult-theme
  ;;  :preview-key '(:debounce 0.2 any)
  ;;  consult-ripgrep
  ;;  consult-git-grep
  ;;  consult-grep
  ;;  consult-bookmark
  ;;  consult-recent-file
  ;;  consult-xref
  ;;  consult--source-bookmark
  ;;  consult--source-file-register
  ;;  consult--source-recent-file
  ;;  consult--source-project-recent-file
  ;;  :preview-key '(:debounce 0.4 any))

  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
	 )

(use-package consult-dir
  :after consult
  :bind (("C-x C-d" . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file))
  :custom
  (consult-find-args "find .")
  (consult-dir-project-list-function 'consult-dir-projectile-dirs))

(use-package consult-projectile
;;  :after (consult projectile)
  :bind ("C-c q" . consult-projectile))

(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt
;;  (corfu-auto t)
  (corfu-popupinfo-mode t)
  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :init
  (global-corfu-mode))



(use-package diminish
  :demand t)



(use-package dune)

(use-package eglot
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (tuareg-mode . eglot-ensure))

  )
(use-package embark
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
                 (window-parameters (mode-line-format . none)))
	       )

  (with-eval-after-load 'ace-window
    (eval-when-compile
      (defmacro my/embark-ace-action (fn)
	`(defun ,(intern (concat "my/embark-ace-" (symbol-name fn))) ()
	   (interactive)
	   (with-demoted-errors "%s"
             (require 'ace-window)
             (let ((aw-dispatch-always t))
               (aw-switch-to-window (aw-select nil))
               (call-interactively (symbol-function ',fn)))))))
    (define-key embark-file-map     (kbd "o") (my/embark-ace-action find-file))
    (define-key embark-buffer-map   (kbd "o") (my/embark-ace-action switch-to-buffer))
    (define-key embark-bookmark-map (kbd "o") (my/embark-ace-action bookmark-jump))
    ))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package jwiegley
  :load-path "~/lisp")

(use-package kpm-list
  :bind (("C-x C-b" . kpm-list)))


(use-package magit
  :defer t
  )

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package matm-opam
  :load-path "~/lisp"
  :hook (tuareg-load . opam-setup)
  )
;; (use-package opam-user-setup
;;    :load-path ".emacs.d" 
;;    :hook (tuareg-mode ocp-setup-indent)) 

;; (use-package org-download
;;   :defer t
;;   )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (setq completion-category-defaults  nil))

(use-package personal
  :demand t
  :load-path "~/lisp"
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
;;  (setq enable-recursive-minibuffers t)

 ;; :config
;;  (add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)
  ;; (require-theme 'modus-themes) ; `require-theme' is ONLY for the built-in Modus themes

  ;; ;; Add all your customizations prior to loading the themes
  ;; (setq modus-themes-italic-constructs t
  ;;       modus-themes-bold-constructs nil)

  ;; ;; ;; Maybe define some palette overrides, such as by using our presets
  ;; ;; (setq modus-themes-common-palette-overrides
  ;; ;;       modus-themes-preset-overrides-intense)

  ;; ;; Load the theme of your choice.
  ;; (load-theme 'modus-vivendi)
  ;; (setq modus-themes-to-toggle '(modus-vivendi-tinted modus-operandi-tinted))
  ;; ;;(modus-themes-toggle)
  (load-theme 'ef-deuteranopia-dark t)

  :bind (("C-c u" . switch-math-input-method)
         ("C-c M-q" . unfill-paragraph)
	 ;;("<f5>" . modus-themes-toggle)
	 )
  :custom
  (custom-file "~/.emacs.d/settings.el")
  (tool-bar-mode nil)
  (auth-source-save-behavior nil)	  
;;  (custom-enabled-themes '(ef-deuteranopia-dark))	  
  (recentf-mode t)
  (inhibit-startup-screen t)
  (backup-directory-alist '(("." . "~/emacs-backups")))
  (use-short-answers t))			  

(use-package popper
;;  :after projectile
  :bind (("C-`"   . popper-toggle-latest)
         ("C-~"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :custom
  (popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode t)
  (popper-echo-mode t)
  ;;  (popper-group-function 'popper-group-by-projectile)
  )                



(use-package projectile
  :commands (popper-group-by-projectile)
  :defer 5
  :diminish
  :bind* (("C-c TAB" . projectile-find-other-file)
          ("C-c P" . (lambda () (interactive)
		       (projectile-cleanup-known-projects)
		       (projectile-discover-projects-in-search-path))))
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode)

  (defun my-projectile-invalidate-cache (&rest _args)
    ;; We ignore the args to `magit-checkout'.
    (projectile-invalidate-cache nil))

  (eval-after-load 'magit-branch
    '(progn
       (advice-add 'magit-checkout
                   :after #'my-projectile-invalidate-cache)
       (advice-add 'magit-branch-and-checkout
                   :after #'my-projectile-invalidate-cache)))
  :custom
  (projectile-switch-project-action 'projectile-dired)
  (projectile-project-search-path
   '(("~/ml" . 1)
     ("~/projects" . 1)
     ("~/foreign-projects" . 1))))

(use-package projectile-ripgrep
  :after projectile)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package rg
  :config
  (rg-enable-default-bindings)
  :custom
  (rg-command-line-flags '("--hidden" "-g !.git")))


;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package tuareg
  :custom
  (utop-command "opam config exec -- dune utop . -- -emacs"))

(use-package unicode-math-input)

(use-package vc
  :defer t
  :custom
  (vc-command-messages t)
  (vc-follow-symlinks t)
  (vc-git-diff-switches '("-w" "-U3"))
;  (vc-handled-backends '(GIT))
  (vc-make-backup-files t))

(use-package vertico
  :init
  (vertico-mode)
  :bind
  (:map vertico-map
        ("C-v" . vertico-scroll-up)
        ("M-v" . vertico-scroll-down))  
  :config
  (vertico-mouse-mode)
  ;;(vertico-buffer-mode)
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

;; ;; Configure directory extension.
;; (use-package vertico-directory
;;   :after vertico
;;   ;; More convenient directory navigation commands
;;   :bind (:map vertico-map
;;               ("RET" . vertico-directory-enter)
;;               ("DEL" . vertico-directory-delete-char)
;;               ("M-DEL" . vertico-directory-delete-word))
;;   ;; Tidy shadowed file names
;;   :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package which-key
  :defer 5
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode))


;;(server-start)



;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dbc6d947d551aa03090daf6256233454c6a63240e17a8f3d77889d76fef1749d" default)))
