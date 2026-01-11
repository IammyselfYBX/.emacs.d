;;; init.el --- emacs 启动配置文件

;;; Commentary:
;;; 这是emacs的init.el配置文件
;;; emacs的家目录
;;;  ~/.emacs
;;; ~/.emacs.d/init.el
;;; ~/.config/emacs/init.el (emacs版本 ≥ 27)

;; 将 etc 添加到 load-path 列表中
;;  load-path 是一个包含目录路径的列表，Emacs 在这些目录中查找要加载的 Lisp 文件,然后就可以直接使用 (require 'some-file) 来加载该目录下的 some-file.el 文件
;; 可以下面的写法
;; (add-to-list 'load-path "~/.emacs.d/etc/")
;; 也可以下面的写法
(add-to-list 'load-path
             (expand-file-name (concat user-emacs-directory "etc")))
;; user-emacs-directory 是emacs的家目录， 这里就是 "~/.emacs.d/"
;; (concat 变量1, 变量2) 拼接两个变量 (concat user-emacs-directory "etc") 得到的结果就是 "~/.emacs.d/etc"
;; expand-file-name 的功能就是将 相对路径——>绝对路径 这里就是把 "~/.emacs.d/etc"——>"/home/Handsomeman/.emacs.d/etc/"
;; load-path 的作用是告诉Emacs在哪里可以找到要加载的Lisp文件或库
;;  '作用：变量名前加上单引号（'）的作用是将变量转义，使其成为一个符号（symbol），不具有存储值的功能
;; add-to-list函数 用于将一个元素添加到另一个列表中。这个函数接受两个参数：要添加的元素和目标列表
;;-----------------------------------------------------------
;;引入其他文件
(require 'my_elpa)       ;;配置elpa
(require 'my_custom)     ;;个性化设置

;;===================================
(require 'package)       ;; 引入包管理器，主要是针对elpa的
(require 'use-package)   ;; 引入use-package
(require 'my_use_package);; 配置包管理器

;;===================================
;;(require 'my_org)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 指定固定备份文件路径
(setq backup-directory-alist (quote (("." . "~/.emacs.d/backups/"))))
;;; 恢复文件
;;; M-x recover-file <RET> 文件名 <RET>
;;; yes <RET>
;;; C-x C-s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 定义变量 custom-file，其值为 ~/.emacs.d/etc/gui-custom.el 的完整路径
;; 这通常用于存放由 Emacs 图形化界面自动生成的定制选项
(setq custom-file
      (expand-file-name "gui-custom.el" (concat user-emacs-directory "etc")))
;; 检查 custom-file 指定的文件是否存在
;; 如果存在，则加载并执行该文件的内容。
(when (file-exists-p custom-file)
  (load-file custom-file))




