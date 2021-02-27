;;设置加载目录到 load-path
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "etc")))

(require 'start-up)
