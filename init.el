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


;;force c++ mode on eigen
(add-to-list 'auto-mode-alist '("/eigen/Eigen/"  . c++-mode) t)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))


;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; linum mode if c/c++
;;(add-hook 'c++-mode-hook 'linum-mode)
;;(add-hook 'c-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)

;; yasnippet
(add-to-list
 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)

(setq yas-snippet-dir
      '("~/.emacs.d/snippets"))

(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; setup rtags
(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

(require 'irony)
;; ;; irony mode
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(defun nick/irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))


(add-hook 'irony-mode-hook 'nick/irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;;company and irony
(require 'company-irony)
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list 
    'company-backends '(company-irony-c-headers company-irony)))


(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;;tab completion without delay
(setq company-idle-delay 0.2)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)


;; ;;flycheck
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)


(require 'flycheck-rtags)
(defun nick/flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'nick/flycheck-rtags-setup)


;;flycheck iroy
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; ;;cmake ide
(require 'cl)
(require 'rtags)
(cmake-ide-setup)

;;file formatting
(require 'google-c-style)
;;load formatting style
(add-hook 'c-mode-common-hook 'google-set-c-style)

(put 'upcase-region 'disabled nil)
(setq x-select-enable-clipboard nil)
(put 'narrow-to-region 'disabled nil)
