(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(add-to-list 'load-path "~/lisp")



;; more packages from melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(package-initialize) called anyway since  package-enable-at-startup is not disabled

(setq package-selected-packages
      '(use-package
	 ace-window
	 all-the-icons
	 cape
	 consult
	 consult-dir
	 consult-project-extra
	 corfu
	 ;; consult-projectile
	 diminish
	 dune
	 embark
	 embark-consult
	 kpm-list
	 marginalia
	 orderless
	 ;;projectile
	 rg
	 savehist
	 tuareg
	 unicode-math-input
	 vertico
	 which-key
	 ))

;; Install packages with (package-install-selected-packages)

;; Remove packages with (package-autoremove)
;; If you want to automate that, maybe add them to your 'emacs-startup-hook'?

(eval-when-compile
  (require 'use-package))

;; A few more useful configurations...



(use-package ace-window
  :bind* ("M-o" . ace-window)
;;  :custom
;;  (aw-dispatch-when-more-than 6)
;;  (aw-scope 'frame)
  )


(use-package all-the-icons
  :if (display-graphic-p))

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

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
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

(use-package color-moccur
  :disabled
  :commands (isearch-moccur isearch-all isearch-moccur-all)
  :bind (("M-s O" . moccur)
         :map isearch-mode-map
         ("M-o" . isearch-moccur)
         ("M-O" . isearch-moccur-all)))

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
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-exclude-modes'.
  :init
  (global-corfu-mode))


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

(use-package diminish
  :demand t)

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

(use-package dune)

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
                 (window-parameters (mode-line-format . none))))

  


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
  )


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

(use-package jwiegley)

(use-package kpm-list
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
;;   )

;; (use-package latex-unicode-math-mode
;;   ;;   :config
;;   :commands (latex-unicode-mode
;; 	     latex-unicode-math-mode
;; 	     latex-unicode-convert-region latex-unicode-convert-buffer
;; 	     latex-unicode-invert-region latex-unicode-invert-buffer))

(use-package magit
  :disabled
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
  :load-path "lisp"
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
  :load-path "lisp"
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
  (setq enable-recursive-minibuffers t)

 ;; :config
  (defalias 'yes-or-no-p 'y-or-n-p)
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
  

  :bind (("C-c u" . switch-math-input-method)
         ("C-c M-q" . unfill-paragraph)
	 ;;("<f5>" . modus-themes-toggle)
	 :map comint-mode-map
	 ("C-c M-o" . comint-clear-buffer))
  :custom
  (tool-bar-mode nil)
  (auth-source-save-behavior nil)	  
  (custom-enabled-themes '(tango-dark))	  
  (recentf-mode t)
  (inhibit-startup-screen t))			  


;; (use-package posframe                      
;;   :config                                  
;;   (require 'posframe))                     




(use-package projectile
  :defer 5
  :diminish
  :bind* (("C-c TAB" . projectile-find-other-file)
          ("C-c P" . (lambda () (interactive)
		       (projectile-cleanup-known-projects)
		       (projectile-discover-projects-in-search-path))))
;;  :bind-keymap ("C-c p" . projectile-command-map)
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
                   :after #'my-projectile-invalidate-cache))))

;; (use-package projectile-ripgrep
;;   :disable
;;   :after projectile)


(use-package rg
  :config
  (rg-enable-default-bindings)
  :custom
  (rg-command-line-flags '("--hidden" "-g !.git")))

;; (use-package swiper
;;   :disabled
;;   :diminish
;;   :after ivy
;;   :bind (("C-s" . swiper)))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package tuareg)

(use-package unicode-math-input)

(use-package vc
  :defer t
  :custom
  (vc-command-messages t)
  (vc-follow-symlinks t)
  (vc-git-diff-switches '("-w" "-U3"))
  (vc-handled-backends '(GIT))
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

;; (use-package which-key-posframe
;;   ;;   :after (which-key posframe))

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
