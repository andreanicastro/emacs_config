;; org mode setup

(use-package org
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cb" 'org-iswitchb)
  (define-key global-map "\C-cc" 'org-capture)
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

  ;; org capture templates
  (setq org-capture-templates
	'(
	  ("p"          ; key
	   "Paper"      ; name
	   entry        ; type
	   (file+headline "~/Documents/notes/references/papers.org" "Article") ; target
	   "* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i\nBrief description:\n%?"  ; template
	   :prepend t     ; property: add at the end
	   :empty-lines 1 ; property: one blank line before and after the headline
	   :created t     ; property
	   ))
	)
  )


(use-package org-ref
  :config
  (setq org-ref-bibliography-notes "~/Documents/notes/references/notes"
	org-ref-bibliography-notes "~/Documents/notes/references/papers.org"
	org-ref-default-bibliography '("~/Documents/notes/references/papers.bib")
	org-ref-pdf-directory "~/Documents/notes/references/pdfs/")
  )


(use-package helm-bibtex
  :config
  (setq helm-bibtex-bibliography "~/Documents/notes/references/papers.bib"
	helm-bibtex-library-path "~/Documents/notes/references/pdfs"
	helm-bibtex-notes-path "~/Documents/notes/references/papers.org")
  )

(provide 'orgmode-setup)
