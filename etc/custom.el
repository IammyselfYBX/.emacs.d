;; 存放一些暂时没有归类的自定义配置

;;用 y/n 来代替 yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
;;为了项目管理的统一化，也可以用如下的use-package写法：
;;(use-package emacs :config (defalias 'yes-or-no-p 'y-or-n-p))

;;=========================================
;; 分屏
;;=========================================
(global-set-key (kbd "S-<left>") 'split-window-horizontally)
(global-set-key (kbd "S-<right>") 'split-window-horizontally)
(global-set-key (kbd "S-<down>") 'split-window-horizontally)
(global-set-key (kbd "S-<up>") 'split-window-below)

;;修改分屏大小
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;;通过 ace-window 可快速进行窗口间的跳转
;;  使用 M-o 打开ace-window


;;=========================================
;;org-mode
;;=========================================
;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))


(provide 'custom.el)
