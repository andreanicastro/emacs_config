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
  




(provide 'python-setup)
