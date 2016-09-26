;; set up ido

(use-package ido
  :ensure t
  :config
  (ido-mode)
  (ido-everywhere)
  (setq ido-auto-merge-work-directories-length 1) ;; disable auto merge, C-x C-f only in current dir
  (setq ido-enable-flex-matching t)
  )



(provide 'ido-setup)

