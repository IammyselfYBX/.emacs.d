(scroll-bar-mode -1) ;;关闭右侧滚动条
(menu-bar-mode -1)   ;;关闭菜单栏
(tool-bar-mode -1)    ;;关闭工具栏

;;关闭启动界面
(setq inhibit-startup-screen t)

;;设置行号
(use-package emacs
    :config
    ;;(setq display-line-numbers-type 'relative)
    (setq display-line-numbers-type 'absolute)
    (global-display-line-numbers-mode t))

;;光标变成竖线(仅GUI)
(setq-default cursor-type 'bar)

;;高亮括号
(show-paren-mode 1)

;;上下保留3行
(setq scrol-margin 3)



(provide 'init-ui)
