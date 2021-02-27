;;更改国内源
(setq package-archives '(
    ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
    ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(setq package-check-signature nil) ;;个别时候会出现签名校验失败
(require 'package) ;; 初始化包管理器
(require 'use-package)

;;初始化包管理器
(unless (bound-and-true-p package--initialized)
  (package-initialize)) ;; 刷新软件源索引

;;刷新软件源索引
(unless package-archive-contents
    (package-refresh-contents))

;;每次都要检查是否有use-package，没有的话安装并刷新软件源索引
(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

(provide 'init-elpa)


