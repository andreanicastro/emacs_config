;; cpp setup

;;configure yasnippet 
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


;;company and irony
(require 'company-irony)
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list 
    'company-backends '(company-irony-c-headers company-irony)))


(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)


;; irony
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

;;tab company completion without delay
(setq company-idle-delay 0.2)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)

;; flycheck
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




(provide 'cpp-setup)
