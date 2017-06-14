

(use-package yasnippet
  :ensure t
  :load-path "~./.emacs.d/plugins/yasnippet"
  :commands (yas-minor-mode)
  :init
  (setq yas-snippet-dir
	'("~/.emacs.d/snippets"))
  (progn (add-hook 'prog-mode-hook #'yas-minor-mode))
  :config
  (yas-reload-all)
  )





(provide 'yasnippet-setup)
