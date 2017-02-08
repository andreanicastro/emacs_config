;; org mode setup

(use-package org
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t) 


  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
 
  (setq org-image-actual-width '(300))

  (setq org-todo-keywords
	'((sequence "TODO" "ACTIVE" "DONE")))
  )





(provide 'orgmode-setup)
