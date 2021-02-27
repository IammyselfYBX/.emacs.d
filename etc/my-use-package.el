;; use-package 官方推荐配置
(eval-and-compile
    (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字
    (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t
    (setq use-package-always-demand nil)
    (setq use-package-expand-minimally t)
    (setq use-package-verbose t))

;;restart-emacs
(use-package restart-emacs)

;;================================================
;; 外观
;;===============================================
;; 主题 
(use-package gruvbox-theme
    :init (load-theme 'gruvbox-dark-soft t))
;;mode-line
(use-package smart-mode-line
    :init
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'respectful)
    (sml/setup))

;;=============================================
;; 性能
;;==============================================
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))



(provide 'my-use-package)
