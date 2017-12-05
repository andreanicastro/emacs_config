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
			       "~/notes/ideas.org"
			       "~/notes/thoughts.org"))

  (setq org-agenda-custom-commands
	'(("A" todo "ACTIVE")
	  ("v" tags-todo "VIN")
	  ("u" tags-todo "STUDY")))

  ;; org capture templates
  (setq org-capture-templates
	'(
	 ; ("p"          ; key
	 ;  "Paper"      ; name
	 ;  entry        ; type
	 ;  (file+headline "~/notes/thesis.org" "Relevant Literature") ; target
	 ;  "** %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i\nBrief description:\n%?"  ; template
	 ;  :prepend t     ; property: add at the end
	 ;  :empty-lines 1 ; property: one blank line before and after the headline
	 ;  :created t     ; property
	 ;  )
	 ("s"
	  "Study"
	  entry 
	  (file+headline "~/notes/study.org" "Study")
	  "** %^{Matter} :STUDY:%(org-set-tags)"
	  :created t
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
	  ("b"
	   "Bad Thought"
	   entry
	   (file "~/notes/thoughts.org")
	   "* %U %^{THOUGHT}\n ** SITUATION \n(What happened? Where? When? Who with? How?) \n** EMOTION MOODS \n(rate 0-100%, What emotion did I feel at that time? What else? How intense was it?) \n**PHYSICAL sensation and reaction \n(What did I notice in my body? What whould other notics about me?) \n** UNHELPFUL THOUGHT IMAGES \n(What went through my mind? What disturbed me? What did those thoughts/images/ memories mean to me, or say about me or the situation? WHat I am responding to? What button is this pressing for me? What would be the worst thing about that? Am I over-estimating the danger? Am I unde-estimating my ability to cope? Is this fact or opinion?) \n** ALTERNATIVE REALISTIC THOUGHT. MORE BALANCED PERSPECTIVE \n(STOP, take a breath. WHat would someone else say about this situation? What's the bigger picture? Is there another way of seeing it? What advice would I give someone else in this situation?) \n** WHAT I DID? WHAT I COULD DO? WHAT IS THE BEST RESPOSE? \n(What will the consequences of my action be? Do what works! Act wisely. What will be the most helful for me, for others, or the situation? What could I do differently? What would be more effective? \** QUESTIONS TO BE ANSWERED: \n*** Is there a substantial evidence for my thought? \n*** Is there evidence contrary to my thought? \n*** Am I attempting to interpret this situation without all the evidence? \n*** What would a friend think about this situation? \n*** If I look a the situation positively, how is it different? \n*** Will this matter a year from now? How about five years from now? "
	   :empyt-lines 1
	   :created t
	   )
	  
	  
	  ("i"
	   "Idea"
	   entry
	   (file "~/notes/ideas.org")
	   "* %^{Title} :IDEAS:%(org-set-tags) \n"  ; template
	   :empty-lines 1
	   :created t
	   )
	 ("t"
	  "Todo"
	  entry
	  (file+headline "~/notes/todo.org" "Tasks")
	  "** TODO %^{Content} %(org-set-tags)"
	  :prepend t
	  :created t
	  )
	 ("q"
	  "Question"
	  entry
	  (file "~/notes/questions.org")
	  "** TODO %^{Question} %(org-set-tags)"
	  :created t
	  )
	  ;("l"
	  ; "LifeTodo"
	  ; entry
	  ; (file+headline "~/notes/life.org" "todo list")
	  ; "** TODO %^{Content} :LIFE: %^G \n"  ; template
	  ; :created t
	  ; )
	  
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
