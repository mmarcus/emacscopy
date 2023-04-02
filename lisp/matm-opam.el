
(defun opam-setup ()
  (interactive)
  (add-to-list 'load-path
	       "~/.opam/default/share/emacs/site-lisp")
  (require 'ocp-indent)

  (let ((opam-share (ignore-errors (car (process-lines "opam" "var"
						       "share")))))
    (when (and opam-share (file-directory-p opam-share))
      ;; Register Merlin
      (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
      ;;    (add-to-list 'load-path "/home/mmarcus/.opam/default/share/emacs/site-lisp")
      (autoload 'merlin-mode "merlin" nil t nil)
      ;; Automatically start it in OCaml buffers
      (add-hook 'tuareg-mode-hook 'merlin-mode t)
      (add-hook 'caml-mode-hook 'merlin-mode t)
      ;; Use opam switch to lookup ocamlmerlin binary
      (setq merlin-command 'opam)))

  ;; (use-package ocp-indent
  ;;   :load-path "~/.opam/default/share/emacs/site-lisp"
  ;;   :hook (tuareg-mode caml-mode). ocp-setup-indent)


  ;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
  (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
  ;; ## end of OPAM user-setup addition for emacs / base ## keep this line

  )

(provide 'matm-opam)
