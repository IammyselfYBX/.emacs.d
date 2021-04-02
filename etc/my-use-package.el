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

;;=====================================
;; 分屏
;;=====================================
(use-package ace-window
    :bind (("M-o" . 'ace-window)))


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
;;自动补全，定义跳转，查找所有引用 
;;=====================================
;; 补全
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

;;lsp
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;;(XXX-mode . lsp)
	 ;;全部编程语言(prog-mode . lsp)
	 ;; lsp 是 emacs 启动就启用
	 ;; lsp-deferred 是进入某个模式才启用
	 ;;如果想 推迟加载使用(XXX-mode . lsp-deferred)
	 (c++-mode .lsp-deferred)
	 (c-mode . lsp-deferred)
	 (java-mode .lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

;;ccls
(setq ccls-executable "/usr/bin/ccls")
;; (setq ccls-args '("--log-file=/tmp/ccls.log"))







;;=====================================
;; 语法检查
;;=====================================
(use-package flycheck ;;全局
  :hook (after-init . global-flycheck-mode))
;;只在编程语言下启用
;;(use-package flycheck
;;  :hook (prog-mode . flycheck-mode))

(setq lsp-prefer-flymake nil)




;;=====================================
;; 辅助记忆
;;=====================================
(use-package which-key
  :defer nil
  :config (which-key-mode))


;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )



(provide 'my-use-package)
