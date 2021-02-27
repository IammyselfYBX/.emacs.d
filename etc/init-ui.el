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

;;
(show-paren-mode 1)

(setq scrol-margin 3)



(provide 'init-ui)
