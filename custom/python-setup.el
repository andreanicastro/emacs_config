;;python setup



(use-package elpy
  :ensure
  :commands
  elpy-enable

  :init

  ;; check if python mode
  (with-eval-after-load 'python (elpy-enable))

  :config
  ;;set jedi as backed and enable flymake
  (progn
    (setq elpy-rpc-backend "jedi"
	  elpy-rpc-project-specific 't)
    (when (fboundp 'flycheck-mode)
      (setq elpy-modules (delete 'elpy-module-flymake elpy-modules))))


  )




(provide 'python-setup)
