;; org mode setup

(use-package interleave
  :ensure t
  )

;; set the character limit line
(use-package fill-column-indicator
  :ensure t
  :commands (fci-mode)
  :init
  (add-hook 'org-mode-hook 'fci-mode)
  :config

  (setq fci-rule-column 90)
  
  ;; workaround to avoid intereference with company
  (defun on-off-fci-before-company(command)
  (when (string= "show" command)
    (turn-off-fci-mode))
  (when (string= "hide" command)
    (turn-on-fci-mode)))

  (advice-add 'company-call-frontends :before #'on-off-fci-before-company)
)  







(use-package org
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cb" 'org-iswitchb)
  (define-key global-map "\C-cc" 'org-capture)
  (setq org-log-done t) 


  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.2))
  
  (setq org-image-actual-width '(300))
  (setq org-highlight-latex-and-related '(latex))

  (setq org-todo-keywords
	'((sequence "TODO" "ACTIVE" "DONE")))

  (setq org-agenda-files (list "~/notes/thesis.org"
			       "~/notes/life.org"
			       "~/notes/meetings.org"
			       "~/notes/papers.org"
			       "~/notes/ideas.org"))

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
	   (file+headline "~/notes/thesis.org" "Relevant Literature") ; target
	   "** %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i\nBrief description:\n%?"  ; template
	   :prepend t     ; property: add at the end
	   :empty-lines 1 ; property: one blank line before and after the headline
	   :created t     ; property
	   )
	  ("m"
	   "Meeting"
	   entry
	   (file "~/notes/meetings.org")
	   "* %U %(org-set-tags)\n** Content\n%?\n** Comments"  ; template
					;:prepend t
	   :empty-lines 1
	   :created t
	   )
	  
	  ("i"
	   "Idea"
	   entry
	   (file "~/notes/ideas.org")
	   "* %^{Title} :IDEAS: \n"  ; template
	   :empty-lines 1
	   :created t
	   )
	  
	  ("l"
	   "LifeTodo"
	   entry
	   (file+headline "~/notes/life.org" "todo list")
	   "** TODO %^{Content} :LIFE: %^G \n"  ; template
	   :created t
	   )
	  
	  )
	)
  )


(use-package org-ref
  :ensure t
  :config
  (setq org-ref-bibliography-notes "~/notes/references/notes"
	org-ref-bibliography-notes "~/notes/references/papers.org"
	org-ref-default-bibliography '("~/notes/references/papers.bib")
	org-ref-pdf-directory "~/notes/references/pdfs/")

  (setq org-ref-note-title-format "* %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :INTERLEAVE_PDF: ./pdfs/%k.pdf\n :END:\n\n") 
  )


(use-package helm-bibtex
  :config
  (setq helm-bibtex-bibliography "~/notes/references/papers.bib"
	helm-bibtex-library-path "~/notes/references/pdfs"
	helm-bibtex-notes-path "~/notes/references/papers.org")

  (defun my/org-ref-notes-function (candidates)
    (let ((key (helm-marked-candidates)))
      (funcall org-ref-notes-function (car key))))
  (helm-delete-action-from-source "Edit notes" helm-source-bibtex)
  (helm-add-action-to-source "Edit notes" 'my/org-ref-notes-function helm-source-bibtex 7)
  )

(provide 'orgmode-setup)
