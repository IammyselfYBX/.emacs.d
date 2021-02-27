;;设置加载目录到 load-path
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "etc")))

(require 'startup)
(require 'init-ui)
;;软件源
(require 'init-elpa)
(require 'my-use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(restart-emacs use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
