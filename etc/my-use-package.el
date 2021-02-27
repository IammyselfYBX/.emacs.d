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

;;============================================
;;文本编辑之强化搜索
;;===========================================
;; ivy-counsel-swiper三剑客，同时优化了一系列 Minibuffer 的操作
(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-count-format "%d/%d "
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel
  :after (ivy)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
                swiper-include-line-number-in-search t))

;;显示在左下角的 MiniBuffer 移动视线范围大，移动到中央位置
;; https://github.com/tumashu/ivy-posframe
;; 仅在 GUI 才会有用
;; (use-package ivy-posframe
;;   :init
;;   (setq ivy-posframe-display-functions-alist
;;     '((swiper . ivy-posframe-display-at-point)
;;       (complete-symbol . ivy-posframe-display-at-point)
;;       (counsel-M-x . ivy-posframe-display-at-frame-center)
;;       (counsel-find-file . ivy-posframe-display-at-frame-center)
;;       (ivy-switch-buffer . ivy-posframe-display-at-frame-center)
;;       (t . ivy-posframe-display-at-frame-center)))
;;   (ivy-posframe-mode 1))



;;======================================
;; 补全
;;=====================================
(use-package company
  :config
  (setq company-dabbrev-code-everywhere t  ;;任何情况都补全
        company-dabbrev-code-modes t
        company-dabbrev-code-other-buffers 'all
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case t
        company-dabbrev-other-buffers 'all
        company-require-match nil
        company-minimum-prefix-length 2 ;;输入2个字母开始补全
        company-show-numbers nil
        company-tooltip-limit 20
        company-idle-delay 0
        company-echo-delay 0
        company-tooltip-offset-display 'scrollbar
        company-begin-commands '(self-insert-command))
  (push '(company-semantic :with company-yasnippet) company-backends)
  :hook ((after-init . global-company-mode)))

;;=====================================
;; 语法检查
;;=====================================
(use-package flycheck ;;全局
  :hook (after-init . global-flycheck-mode))
;;只在编程语言下启用
;;(use-package flycheck
;;  :hook (prog-mode . flycheck-mode))



;;=====================================
;; 辅助记忆
;;=====================================
(use-package which-key
  :defer nil
  :config (which-key-mode))




(provide 'my-use-package)
