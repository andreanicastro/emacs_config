;; cpp setup

;;force c++ mode on eigen and cuda
(add-to-list 'auto-mode-alist '("/eigen/Eigen/"  . c++-mode) t)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

;; set yasnippet
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




;; rtags for tags based on clang
(use-package rtags
  :ensure t
  :config
  (setq rtags-completions-enabled t)
  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings)
)

;; rtags based backend for company
(use-package company-rtags
  :after rtags company
  :config
  (add-to-list 'company-backends 'company-rtags)
  )


;; irony based backend for company
(use-package company-irony
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-irony)
  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
  )


;; irony based backend for company to complete headers
(use-package company-irony-c-headers
  :after company
  :config
  (add-to-list 'company-backends 'company-irony-c-headers)
  )


  
;; irony mode for c++
(use-package irony
  :ensure t
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


;; flycheck
(use-package flycheck
  :ensure t
  :commands (flycheck-mode)
  :init
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)
  )
;; set up the flycheck interface with rtags
(use-package  flycheck-rtags
  :after flycheck 
  :config 
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil)
  )


;; set up the flycheck interface with irony
(use-package flycheck-irony-setup
  :after flycheck irony
  :config  
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  )






;; ;; company bindings
;; ;; not nice here, double check
;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)




;; cmake ide
(use-package cmake-ide
  :ensure t
  :config
  (cmake-ide-setup)
  )

;; custom c++ style for autoindentation
(use-package google-c-style
  :load-path "~/.emacs.d/custom/"
  :config
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  )

;; set the character limit line
(use-package fill-column-indicator
  :ensure t
  :commands (fci-mode)
  :init
  (add-hook 'c-mode-hook 'fci-mode)
  (add-hook 'c++-mode-hook 'fci-mode)
  :config
  ;; 120 char of limit
  (setq fci-rule-column 120)
  
  ;; workaround to avoid intereference with company
  (defun on-off-fci-before-company(command)
  (when (string= "show" command)
    (turn-off-fci-mode))
  (when (string= "hide" command)
    (turn-on-fci-mode)))

  (advice-add 'company-call-frontends :before #'on-off-fci-before-company)
)  

(provide 'cpp-setup)
