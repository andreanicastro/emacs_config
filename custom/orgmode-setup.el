;; org mode setup

(use-package org
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cb" 'org-iswitchb)
  (setq org-log-done t) 


  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.2))
 
  (setq org-image-actual-width '(300))

  (setq org-todo-keywords
	'((sequence "TODO" "ACTIVE" "DONE")))

  (setq org-agenda-files (list "~/Documents/notes/phd.org"
			       "~/Documents/notes/life.org"
			       "~/Documents/notes/meetings.org"
			       "~/Documents/notes/papers.org"
			       "~/Documents/notes/ideas.org"))

  (setq org-agenda-custom-commands
	'(("A" todo "ACTIVE")
	  ("v" tags-todo "VIN")
	  ("u" tags-todo "STUDY")))
  
  )





(provide 'orgmode-setup)
