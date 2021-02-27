;;设置加载目录到 load-path
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "etc")))

;;emacs使用图形化工具自动生成的配置写入
(setq custom-file
    (expand-file-name "gui-custom.el" (concat user-emacs-directory "etc")))
(when (file-exists-p custom-file)
  (load-file custom-file))


(require 'startup)
(require 'init-ui)
;;软件源
(require 'init-elpa)
(require 'my-use-package)

(require 'custom.el)
