;; 该配置文件是用户自定义的配置

;;==========================================================
;; 导入其他库函数
;;----------------------------------------------------------
;; 引入判断操作系统的库
(add-to-list 'load-path "~/.emacs.d/lib/OS")
(require 'judge_os)

;;==========================================================
;; UI界面
;;==========================================================
(scroll-bar-mode -1);;关闭右侧的滚动条
(menu-bar-mode -1)  ;;关闭菜单栏
(tool-bar-mode -1)  ;;关闭工具栏
;;(set-frame-parameter nil 'alpha '(20 . 100)) ;; 设置透明度，但是无效
;; (set-cursor-color "green2") ;; 设置光标颜色，但是无效

;; 启动就是全屏
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;设置窗口位置为屏库左上角(0,0)开始 (向左偏移，向下偏移)
;;(set-frame-position (selected-frame) 100 0)
;;设置emacs 窗口打开时宽和高
;;(set-frame-width (selected-frame) 500)

;;(set-frame-height (selected-frame) 59)
;; 草稿缓冲区默认文字设置
(setq initial-scratch-message (concat ";; Happy hacking, "
                                      (capitalize user-login-name) " - Emacs ♥ you!\n\n"))

;;修改字体大小
;; 已通过 cnfonts 完成修改了(见 my_use_package.el 中 cnfonts 部分)
;;(set-face-attribute 'default nil :height 220)

(setq inhibit-startup-screen t)         ; 不加载启动画面
;;(setq inhibit-startup-message t)        ; 不加载启动消息(等到最后不再新增新的插件开启)
(setq inhibit-startup-buffer-menu t)    ; 不显示缓冲区列表


;;----------------------------------------------------------
;;用 y/n 来代替 yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
;;为了项目管理的统一化，也可以用如下的use-package写法：
;;(use-package emacs :config (defalias 'yes-or-no-p 'y-or-n-p))

;;光标变成竖线(仅GUI)
(setq-default cursor-type 'bar)

;;高亮括号
(show-paren-mode 1)

;;上下保留3行
(setq scrol-margin 3)

;;一行文字太长自动换行
(visual-line-mode t) 
(global-visual-line-mode t) 

;; 光标靠近鼠标时让鼠标自动走开
;;(mouse-avoidance-mode 'jump) ;; 没用
;;----------------------------------------------------------
;; 字体设置
;;没有 cnfont 用下面的配置
;;(set-fontset-font t 'cjk-misc "Noto Sans CJK SC Regular")
;;(global-set-key (kbd "C--") 'text-scale-decrease)
;;(global-set-key (kbd "C-=") 'text-scale-increase)
;; 有 cnfont 用下面的配置
;; (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
;; (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)
                                        
;;----------------------------------------------------------
;; 行号设置
;; 详见 my_use_package.el 中 "设置行号"
;; 
;; 但是 Emacs 默认 M-g M-g 就可以跳转到某行


;;==========================================================
;; 系统设置
;;==========================================================
;;----------------------------------------------------------
;; 系统编码
;; 配置所有的编码为UTF-8，参考：
;; https://thraxys.wordpress.com/2016/01/13/utf-8-in-emacs-everywhere-forever/
(setq locale-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;;----------------------------------------------------------
;设置垃圾回收阈值，加速启动速度
(setq gc-cons-threshold most-positive-fixnum) ;; 因为现在内存比较大，所以垃圾回收就是内存的最大值
(setq gc-cons-percentage 0.6)                 ;; 一旦达到 最大值的60% 就进行垃圾回收

;;----------------------------------------------------------
;;关闭备份
;; 就是 #文件名# 这种格式的
(setq make-backup-files nil auto-save-default nil)

;;----------------------------------------------------------
;;关闭锁文件
(setq create-lockfiles nil)

;;----------------------------------------------------------
;;总是加载最新的文件
(setq load-prefer-newer t)

;;----------------------------------------------------------
;;关闭字体缓存
(setq inhibit-compacting-font-caches nil)

;; 设置最近打开文件缓存路径
(setq recentf-save-file "~/.emacs.d/var/recentf")
;; 在离开文件时自动将光标的位置保存在文件中。这意味着当您再次打开文件时，光标将放回到同一位置。
(setq save-place-file "~/.emacs.d/var/places")
;; 设置书签文件路径
(setq bookmark-default-file "~/.emacs.d/var/bookmarks")
;;(setq bookmark-file "~/.emacs.d/var/bookmarks")
;; 设置自动保存路径
(setq auto-save-list-file-prefix "~/.emacs.d/var/auto-save-list/.saves~")
;; 设置eshell 历史记录
(setq eshell-history-file-name "~/.emacs.d/var/eshell/history")

;; 设置大文件阈值为100MB，默认10MB
(setq large-file-warning-threshold 100000000)
;; 以16进制显示字节数
(setq display-raw-bytes-as-hex t)
;; 有输入时禁止 `fontification' 相关的函数钩子，能让滚动更顺滑
(setq redisplay-skip-fontification-on-input t)

;; 禁止响铃
(setq ring-bell-function 'ignore)

;; 禁止闪烁光标
(blink-cursor-mode -1)

;; 在光标处而非鼠标所在位置粘贴
(setq mouse-yank-at-point t)

;; 拷贝粘贴设置
(setq select-enable-primary nil)        ; 选择文字时不拷贝
(setq select-enable-clipboard t)        ; 拷贝时使用剪贴板

;; TAB键设置，在Emacs里不使用TAB键，所有的TAB默认为4个空格
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; 设置剪贴板历史长度300，默认为60
(setq kill-ring-max 200)

;; 在剪贴板里不存储重复内容
(setq kill-do-not-save-duplicates t)

;; 在命令行里支持鼠标
(xterm-mouse-mode 1)

;; 退出Emacs时进行确认
(setq confirm-kill-emacs 'y-or-n-p)

;;----------------------------------------------------------
;;记录上一次关闭位置，打开自动跳转
;; 就是 ~/.emacs.d/places 文件
(save-place-mode 1)

;;----------------------------------------------------------
;; Mac OS 设置
;;
;; 将 Command 键映射为 Meta, Option 键 映射为 空
(when *is-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))

	
;;==========================================================
;;分屏
;;==========================================================
(global-set-key (kbd "S-<left>") 'split-window-horizontally)
(global-set-key (kbd "S-<right>") 'split-window-horizontally)
(global-set-key (kbd "S-<down>") 'split-window-below)
(global-set-key (kbd "S-<up>") 'split-window-below)

;;修改分屏大小
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;;通过 ace-window 可快速进行窗口间的跳转
;; 正常 emacs 的跳转另外分屏是 <C-x> o (这里是字母o,不是数字0),但是可以使用ace-window插件
;;  使用 M-o 打开ace-window

;;==========================================================
;; 快捷键
;;==========================================================
;; 用 ESC 替换 C-g
;;(global-set-key (kbd "<ESC>") (kbd "C-g"))
;; 用 C-z 变成撤销
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-s") 'save-buffer) ;; C-s 保存文档
(global-set-key (kbd "C-w") 'kill-buffer) ;; 关闭当前buffer 相当于C-x k

;;==========================================================
;; 编程
;;----------------------------------------------------------
;; python 
;; 解决emacs 打开python 报错 : emacs can't guess python-indent-offset using defaults 4
(setq python-indent-guess-indent-offset t)           ;; emacs推测python的缩进
(setq python-indent-guess-indent-offset-verbose nil) ;; emacs 不显示上述提示

;; 复制粘贴



;;==========================================================
;; 文件结束
(provide 'my_custom)
;;(provide '文件名) 类似C语言的函数名，这样其他文件才可以调用(require '文件名)
;;如果没有 (provide 'XXX)的话，就会出现
;;error: Loading file /home/tony/.emacs.d/etc/init_ui.el failed to provide feature ‘init_ui’
