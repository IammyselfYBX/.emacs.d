;; 存放一些暂时没有归类的自定义配置

;;用 y/n 来代替 yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
;;为了项目管理的统一化，也可以用如下的use-package写法：
;;(use-package emacs :config (defalias 'yes-or-no-p 'y-or-n-p))




(provide 'custom.el)
