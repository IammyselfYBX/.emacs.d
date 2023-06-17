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
;; 导入其他库函数
;; --------------------------------------------------------
;; 引入判断操作系统的库
(add-to-list 'load-path "~/.emacs.d/lib/OS")
(require 'judge_os)

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

;;--------------------------------------------------------
;; 安装 benchmark-init
;; 查看 emacs 启动时间
;; https://github.com/dholm/benchmark-init-el
;; 使用：
;; M-x benchmark-init/show-durations-tabulated ;; 以列表结构展示
;; M-x benchmark-init/show-durations-tree      ;; 以树形结构展示
;; 按 q 推出

(use-package benchmark-init
  :config
  ;; emacs打开以后就禁止 benchmark 收集数据了
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  ;; :hook
  ;; (after-init . benchmark-init/deactivate)
  )


;;==========================================================
;; 外观配置
;;==========================================================
;;-----------------------------------------------
;; 主题配置
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

;;-----------------------------------------------
;; mode-line(状态栏)配置
;; 需要先加载主题才能加载状态栏
(use-package smart-mode-line
    :init
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'respectful)
    (sml/setup))

;;-----------------------------------------------
;; dashboard
;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :init
  (dashboard-setup-startup-hook)
  :config
  (setq dashboard-banner-logo-title "杨秉学的Emacs")
  (setq dashboard-init-info "This is YBX Emacs")
  (setq dashboard-footer-messages nil)
  (setq dashboard-set-navigator t)
  (setq show-week-agenda-p t)
  (setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        ;;(projects . 5)
                        (agenda . 5)))
  (setq dashboard-startup-banner nil)
  ;(setq dashboard-startup-banner "~/.emacs.d/.dashboard_startup.png")
  )

;;-----------------------------------------------
;;设置行号
(use-package emacs
    :unless *is-windows*   ;; 在windows中不开启行号
    :config
    ;;(setq display-line-numbers-type 'relative) ;;设置相对行号
    (setq display-line-numbers-type 'absolute)   ;;设置绝对行号
    (setq linum-format "%4d ") ;;行号显示和文本区域中间有间隔
    (global-set-key (kbd "<f9>") 'linum-mode) ;;设置快捷键
    ;;    (global-display-line-numbers-mode t)
    )

;;-----------------------------------------------
;; 字体设置 cnfonts
;; https://github.com/tumashu/cnfonts
;; cnfonts 的核心很简单，就是让中文字体和英文字体使用不同的字号，从而 实现中英文对齐。
;;
;; 修改字体
;;    | 命令                      | 功能         |
;;    |---------------------------+--------------|
;;    | cnfonts-edit-profile      | 调整字体设置 |
;;
;; 修改字号
;;   cnfonts 的字号信息是存储在 ~/.emacs.d/cnfonts/cnfonts.conf 里面，通过以下命令修改字号，结果写入到配置文件中
;;   | 命令                      | 功能         |
;;   |---------------------------+--------------|
;;   | cnfonts-increase-fontsize | 增大字号     |
;;   | cnfonts-decrease-fontsize | 减小字号     |
;;
;;
(use-package cnfonts
     :init
     (cnfonts-mode 1) ;;启动 emacs 激活cnfonts
     :hook
     (after-make-frame-functions . cnfonts-set-font)
     (cnfonts-set-font . cnfonts-set-font)
  )


;;================================================
;; 文本编辑——强化搜索
;;================================================
;; ivy-counsel-swiper三剑客，同时优化了一系列 Minibuffer 的操作
;; https://github.com/abo-abo/swiper

;; ivy是一个通用的命令补全接口
;;  主要是为Counsel 和 Swiper 提供基础支持
;;  ivy 的补全是通过 Minibuffer 来显示的
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

;; swiper 是用于搜索的插件
;;    对标Emacs中的 isearch ，它使用 Ivy 来显示所有匹配项的概览。
;;   主要为Counsel 提供搜索功能
;;   技术手册：https://oremacs.com/swiper/
(use-package swiper
  :after ivy
  :bind (("C-f" . swiper)
         ("C-S-f" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
                swiper-include-line-number-in-search t))

;; Counsel 主要是将emacs中的一些命令功能增强了，这些命令经过定制以充分利用 Ivy
;;   安装Counsel将同时安装Ivy和Swiper作为依赖
;;   其中 ivy 和 swiper 都是为增强 Counsel 服务的
(use-package counsel
  :after (ivy)
  :bind (("M-x" . counsel-M-x)           ;; 替换emacs原生的 M-x 键
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))


;;=================================================
;; 补全/检查/智能
;;=================================================
;; company 补全
;; http://company-mode.github.io/
;; https://github.com/company-mode/company-mode
;;
;;  简单来说 dabbrev 是 Emacs 的内置包，通过对当前缓冲区的文本进行搜索来完成匹配功能
;;  company 是通过添加许多包来完善 dabbrev 功能(eg:为语义信息、片段和其他类型的数据提供补全的能力)
;;  comapny 的后端就是 `company-dabbrev`
;;    它的工作原理是使用 dabbrev 包在当前缓冲区的文本中搜索匹配项
;;    可以配置补全候选的最小长度，是否忽略大小写，是否在注释和字符串中进行搜索
;;    company-dabbrev 后端默认仅在当前缓冲区中搜索完成候选，但是 "company-dabbrev-code-other-buffers" 可以设置其他缓冲区
;;  company-backends 是 company 提供完成候选的所有后端的列表。
;;    列表中后端的顺序很重要，因为列表中的第一个后端将首先使用，然后是第二个后端，依此类推。
;;  company-semantic 是根据语义补全的后端
;;  company-yasnippet 是根据 yasnippet 补全的后端
;;  
(use-package company
  :config
  (setq company-dabbrev-code-everywhere t         ;; 任何情况都补全
        company-dabbrev-code-modes t              ;; 开启company-dabbrev-code-modes
        company-dabbrev-code-other-buffers 'all   ;; 在全部缓冲区中搜索后选项(尽管这会让显示匹配的速度下降)
	company-dabbrev-other-buffers 'all        ;; 
        company-dabbrev-downcase nil              ;; 在显示完成候选者之前 不全转换成小写
        company-dabbrev-ignore-case t             ;; 不忽略大小写
        company-require-match nil                 ;; 不用键入完整的字符串，仅敲待输入字符串的前几个字母就可以实现补全
        company-minimum-prefix-length 2           ;; 输入2个字母开始补全
        company-show-numbers nil                  ;; 不显示候选词的编号
        company-tooltip-limit 20                  ;; 候选次最多 20 个
        company-idle-delay 0                      ;; 当用户停止输入 0 秒(默认是 0.2)后，弹出候选框
        company-echo-delay 0                      ;; 当用户停止输入 0 秒(默认是 0.1)后，候选框显示候选词
        company-tooltip-offset-display 'scrollbar ;; 如果候选词比较多，以滚动条的形式显示 | 另一个选项是 (setq company-tooltip-offset-display 'lines) 就是全部显示
        company-begin-commands '(self-insert-command org-self-insert-command ))	;;设置在org-mode 模式下自动补全
  (push '(company-semantic :with company-yasnippet) company-backends) ;; 将 company-semantic 和 company-yasnippet 后端添加到 company-backends 列表的末尾
  :hook ((after-init . global-company-mode))      ;; 开机就启动
  )

;;=================================================

;;文档结束
(provide 'my_use_package)
