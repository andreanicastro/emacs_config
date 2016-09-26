;; cpp setup

;;force c++ mode on eigen and cuda
(add-to-list 'auto-mode-alist '("/eigen/Eigen/"  . c++-mode) t)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))


(use-package yasnippet
  :load-path "~./.emacs.d/plugins/yasnippet"
  :commands (yas-minor-mode)
  :init
  (setq yas-snippet-dir
	'("~/.emacs.d/snippets"))
  (progn (add-hook 'prog-mode-hook #'yas-minor-mode))
  :config
  (yas-reload-all)
  )


(use-package rtags
  :config
  (setq rtags-completions-enabled t)
  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings)
)

(use-package company-rtags
  :after rtags company
  :config
  (add-to-list 'company-backends 'company-rtags)
  )


(use-package company-irony
  :after company
  :config
  (add-to-list 'company-backends 'company-irony)
  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
  )

(use-package company-irony-c-headers
  :after company
  :config
  (add-to-list 'company-backends 'company-irony-c-headers)
  )
  

(use-package irony
  :commands (irony-mode)
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  :config
  ;; check correctness
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
)


;; company bindings
;; not nice here, double check
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)


(use-package flycheck
  :commands (flycheck-mode)
  :init
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)
  )

(use-package flycheck-rtags
  :after flycheck
  :config
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil)
  )


(use-package flycheck-irony-setup
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  )



;; ;;cmake ide
(require 'cl)
(require 'rtags)
(cmake-ide-setup)


(use-package google-c-style
  :load-path "~/.emacs.d/custom/"
  :config
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  )



(provide 'cpp-setup)
