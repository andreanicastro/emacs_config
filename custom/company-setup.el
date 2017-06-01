
(use-package company
  :ensure t
  ;;:defer t
  :init ( add-hook 'after-init-hook 'global-company-mode)
  :bind ("C-;" . company-complete)
  ;; (
  ;;  ;; :map
  ;;  ;; c-mode-map ([(tab)] . company-complete)
  ;;  :map
  ;;  c++-mode-map ([(tab)] . company-complete))
  :config
  ;; (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.1)
)

(use-package helm-company
  :ensure t
  :after company
  :config
  (define-key company-mode-map (kbd "C-;") 'helm-company)
  (define-key company-active-map (kbd "C-;") 'helm-company)
  )


(provide 'company-setup)
