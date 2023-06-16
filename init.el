;; 这是emacs的init.el配置文件
;;; 配置文件位置					;
;;;  ~/.emacs
;;; ~/.emacs.d/init.el
;;; ~/.config/emacs/init.el (emacs版本 ≥ 27)

;;设置加载目录到 etc 文件
(add-to-list 'load-path "~/.emacs.d/etc/")

;; emacs 如果使用图形界面的设置生成的配置文件位置
(setq custom-file
      (expand-file-name "gui-custom.el" (concat user-emacs-directory "etc")))
(when (file-exists-p custom-file)
  (load-file custom-file))

;; 指定固定备份文件路径
(setq backup-directory-alist (quote (("." . "~/.emacs.d/backups/"))))
;;; 恢复文件
;;; M-x recover-file <RET> 文件名 <RET>
;;; yes <RET>
;;; C-x C-s



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;引入其他文件
(require 'my_custom)     ;;个性化设置
(require 'my_elpa)       ;;配置elpa

;;===================================
(require 'package)       ;; 引入包管理器，主要是针对elpa的
(require 'use-package)   ;; 引入use-package
(require 'my_use_package);; 配置包管理器
