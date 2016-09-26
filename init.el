(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((cmake-ide-build-dir "build/") (cmake-ide-build-dir "./build/") (cmake-ide-build-dir . "build/")))))

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
	     '("melpa" . "http://stable.melpa.org/packages/") t)
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


;; set up python
(require 'python-setup)

;; setup org
(require 'orgmode-setup)


;; company
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
)


;;force c++ mode on eigen
(add-to-list 'auto-mode-alist '("/eigen/Eigen/"  . c++-mode) t)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))



;; set up c++
(require 'cpp-setup)






;; linum mode if prog language
(add-hook 'prog-mode-hook 'linum-mode)



(put 'upcase-region 'disabled nil)
(setq x-select-enable-clipboard nil)
(put 'narrow-to-region 'disabled nil)

