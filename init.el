(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (org-ref yasnippet company helm-company cmake-mode fill-column-indicator cmake-ide flycheck company-irony rtags use-package expand-region elpy)))
 '(safe-local-variable-values
   (quote
    ((cmake-idle-build-dir . "build/")
     (cmake-ide-build-dir "build/")
     (cmake-ide-build-dir "./build/")
     (cmake-ide-build-dir . "build/")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil :height 100)


;;custom package repository
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(package-initialize)

;; install use-package if not installed 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;buffer movement
(windmove-default-keybindings)


;;custom load path
(add-to-list 'load-path "~/.emacs.d/custom/")
(add-to-list 'load-path "~/.emacs.d/custom/packages/")

;; set up ido
;; (require 'ido-setup)

;; set up helm
(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (helm-mode 1)
  )

;; set up python
;; (require 'python-setup)			

;; setup org
(require 'orgmode-setup)

;; setup expand region
(require 'expand-region-setup) 



;; set up c++
(require 'cpp-setup)

;; linum mode if prog language
(add-hook 'prog-mode-hook 'linum-mode)


(put 'upcase-region 'disabled nil)
(setq x-select-enable-clipboard nil)
(put 'narrow-to-region 'disabled nil)

