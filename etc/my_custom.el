;; 该配置文件是用户自定义的配置

;;===================================
;; UI界面
;;===================================
(scroll-bar-mode -1);;关闭右侧的滚动条
(menu-bar-mode -1)  ;;关闭菜单栏
(tool-bar-mode -1)  ;;关闭工具栏

;; 启动就是全屏
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;设置窗口位置为屏库左上角(0,0)开始 (向左偏移，向下偏移)
;;(set-frame-position (selected-frame) 100 0)
;;设置emacs 窗口打开时宽和高
;;(set-frame-width (selected-frame) 500)
;;(set-frame-height (selected-frame) 59)

;;修改字体大小
(set-face-attribute 'default nil :height 220)

;;; 隐藏打开界面
(setq inhibit-startup-screen t)

;;----------------------------
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

;;--------------------------------
;; 字体设置
;;没有 cnfont 用下面的配置
;;(set-fontset-font t 'cjk-misc "Noto Sans CJK SC Regular")
;;(global-set-key (kbd "C--") 'text-scale-decrease)
;;(global-set-key (kbd "C-=") 'text-scale-increase)
;; 有 cnfont 用下面的配置
;; (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
;; (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)
                                        


;;================================
;; 系统设置
;;================================
;;-----------------------------
;; 系统编码
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;--------------------------
;设置垃圾回收阈值，加速启动速度
(setq gc-cons-threshold most-positive-fixnum) ;; 因为现在内存比较大，所以垃圾回收就是内存的最大值

;--------------------------
;;关闭备份
(setq make-backup-files nil auto-save-default nil)

;--------------------------
;;关闭锁文件
0(setq create-lockfiles nil)

;--------------------------
;;总是加载最新的文件
(setq load-prefer-newer t)

;--------------------------
;;关闭字体缓存
(setq inhibit-compacting-font-caches nil)

;--------------------------
;;记录上一次关闭位置，打开自动跳转
(save-place-mode 1)




;;====================================
;;分屏
;;=========================================
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

;;========================================
;; 文件结束
(provide 'my_custom)
;;(provide '文件名) 类似C语言的函数名，这样其他文件才可以调用(require '文件名)
;;如果没有 (provide 'XXX)的话，就会出现
;;error: Loading file /home/tony/.emacs.d/etc/init_ui.el failed to provide feature ‘init_ui’
