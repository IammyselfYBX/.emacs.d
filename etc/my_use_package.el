;; 这是配置 usepacakge的文档
;;; use-package 是一个宏——用简单统一的方式去管理插件
;;; 官网：https://jwiegley.github.io/use-package/
;;;     ：https://github.com/jwiegley/use-package
;;; Emacs use-package 中文文档：https://github.com/zhangjie2012/use-package-document-cn
;;;
;;; 常用格式
;;; (use-package 包名
;;;    :ensure t       ; 是否一定确保已安装，没有包就自行安装
;;;    :defer nil      ; 是否延迟加载
;;;    :init           ; 初始化参数
;;;    :config         ; 基本配置参数
;;;    :bind           ; 快捷键的绑定
;;;    :hook           ; hook模式的绑定
;;; )


;;==========================================================
;; 总体设置
;;==========================================================
(eval-when-compile
  (setq use-package-always-ensure t)    ;; 不用每个包手动添加:ensure t
  (setq use-package-always-defer t)     ;;默认都是延迟加载
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally t)
  (setq use-package-verbose t)
  )
  

;;--------------------------------------------------------
;; 安装 restart-emacs
;; https://github.com/iqbalansari/restart-emacs
;; [可选] M-x package-refresh-contents RET ;;更新elpa的索引
;; M-x package-install RET restart-emacs
(use-package restart-emacs)
;; 可以按 C-x C-e 直接下载包

;;=================================================
;; 外观配置
;;================================================
;;-----------------------------------------------
;; 主题配置
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

;;---------------------------------------
;; mode-line(状态栏)配置
;; 需要先加载主题才能加载状态栏
(use-package smart-mode-line
    :init
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'respectful)
    (sml/setup))

;;---------------------------------------
;;设置行号
(use-package emacs                                                            
    :config
    ;;(setq display-line-numbers-type 'relative)
    (setq display-line-numbers-type 'absolute)
    (setq linum-format "%4d ") ;;行号显示和文本区域中间有间隔
    (global-set-key (kbd "<f9>") 'linum-mode) ;;设置快捷键
    ;;    (global-display-line-numbers-mode t)
    )




;;==============================================
;; 文本编辑——强化搜索
;;=============================================
;; ivy-counsel-swiper三剑客，同时优化了一系列 Minibuffer 的操作
; (use-package ivy
;   :defer 1
;   :demand
;   :hook (after-init . ivy-mode)
;   :config
;   (ivy-mode 1)
;   (setq ivy-use-virtual-buffers t
;         ivy-initial-inputs-alist nil
;         ivy-count-format "%d/%d "
;         enable-recursive-minibuffers t
;         ivy-re-builders-alist '((t . ivy--regex-ignore-order))))
; 
; (use-package counsel
;   :after (ivy)
;   :bind (("M-x" . counsel-M-x)
;          ("C-x C-f" . counsel-find-file)
;          ("C-c f" . counsel-recentf)
;          ("C-c g" . counsel-git)))
; 
; (use-package swiper
;   :after ivy
;   :bind (("C-s" . swiper)
;          ("C-r" . swiper-isearch-backward))
;   :config (setq swiper-action-recenter t
;                 swiper-include-line-number-in-search t))



;;文档结束
(provide 'my_use_package)
