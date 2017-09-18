;;python setup


(load-theme 'manoj-dark)

(use-package elpy
  :ensure t
  :commands
  elpy-enable

  :init

  ;; check if python mode
  (with-eval-after-load 'python (elpy-enable))

  :config
  ;;set jedi as backed and enable flymake
  (progn
     (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))) 
  )

(use-package flycheck
  :ensure t
  :commands (flycheck-mode)
  :mode 
  :init
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  )

(require 'company-setup)

(use-package company-jedi
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-jedi)
  )
  

;; set the character limit line
(use-package fill-column-indicator
  :ensure t
  :commands (fci-mode)
  :init
  (add-hook 'python-mode-hook 'fci-mode)
  :config
  ;; 80 char of limit
  (setq fci-rule-column 80)
  
  ;; workaround to avoid intereference with company
  (defun on-off-fci-before-company(command)
  (when (string= "show" command)
    (turn-off-fci-mode))
  (when (string= "hide" command)
    (turn-on-fci-mode)))

  (advice-add 'company-call-frontends :before #'on-off-fci-before-company)
)  




(provide 'python-setup)
