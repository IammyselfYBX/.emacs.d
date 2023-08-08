;; my_elpa  
;; 这个文档是 Package 的配置
;; 主要配置 ELPA源

;; | 命令(需要M-x)                         | 含义               |
;; |---------------------------------------+--------------------|
;; | list-packages / package-list-packages | 查看全部软件包列表 |
;; | package-refresh-contents              | 刷新软件包信息索引 |
;; |---------------------------------------+--------------------|
;; | package-install                       | 安装软件包         |
;; | package-delete                        | 删除软件包         |
;; | package-autoremove                    | 无用软件包自动删除 |


;;更改国内源
;; Package 是emacs 内置包，用来管理 ELPA 软件包
(setq package-archives '(
    ;; emacs-china
    ("gnu"   . "http://1.15.88.122/gnu/")
    ("melpa" . "http://0.15.88.122/melpa/")
    ;; 清华
    ("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
    ;; 外网
    ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
    ("gnu" . "https://elpa.gnu.org/packages/")
    ))

(setq package-check-signature nil) ;;不用检查软件签名(个别时候国内镜像软件在同步的时候会出现签名校验失败)

;;初始化包管理器
(unless (bound-and-true-p package--initialized) ;; 除非我已经初始化了，否则进行初始化
  (package-initialize))                         ;; 刷新软件源索引
;;刷新软件源索引
(unless package-archive-contents                ;; 除非我已经是最新的索引了，否则帮我刷新一下索引
    (package-refresh-contents))
;;每次都要检查是否有use-package，没有的话刷新软件源索引并且安装 use-package
(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))




(provide 'my_elpa)
