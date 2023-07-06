;;; my_use_package --- 这是配置 usepacakge的文档
;;; Commentary:
;;; 该配置文件使用 use-package 实现emacs软件包的管理
;;;
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
;;;    :config         ; 基本配置参数,可用于在加载包后执行代码
;;;    :bind           ; 快捷键的绑定
;;;    :hook           ; hook模式的绑定
;;;    :commands       ; 当使用 :commands 关键字时，它会为这些命令创建自动加载，并推迟模块的加载，直到使用它们为止。
;;;    :autoload       ; 自动加载非交互功能
;;; )
;;; :commands 、 :bind 、 :bind* 、 :bind-keymap 、 :bind-keymap* 、 :mode 和 :hook 都暗含 :defer(延迟加载)

;;==========================================================
;; 导入其他库函数
;;----------------------------------------------------------
;; 引入判断操作系统的库
(add-to-list 'load-path "~/.emacs.d/lib/OS")
(require 'judge_os)        ;; 这里是判断操作系统

;; 引入emacs 的自定义库
(add-to-list 'load-path "~/.emacs.d/lib/emacs")
(require 'interaction-log) ;; 这个是交互显示 emacs log 的
;; 想打开 M-x interaction-log-mode 然后 C-x b 在缓冲区就能查看


;;==========================================================
;; 总体设置
;;==========================================================
(eval-when-compile                         ;; 在 emacs 启动的时候进行编译
  (setq use-package-always-ensure t)       ;; 不用每个包手动添加:ensure t
  (setq use-package-always-demand nil)     ;; use-package 仅在另一个包明确需要时才加载该包。这有助于通过减少 Emacs 启动时加载的包的数量来提高性能。  
  ;; (setq use-package-always-defer t)     ;;默认都是延迟加载，这对 benchmark-init 来说不是很好
  (setq use-package-expand-minimally t)    ;; 告诉 use-package 只在必要时扩展 use-package 声明。这有助于提高性能。
  (setq use-package-verbose t)             ;; 告诉 use-package 在加载包时更详细。这有助于调试问题
  )
  
;;----------------------------------------------------------
;; 安装 restart-emacs
;; https://github.com/iqbalansari/restart-emacs
;; [可选] M-x package-refresh-contents RET ;;更新elpa的索引
;; M-x package-install RET restart-emacs
(use-package restart-emacs)
;; 可以按 C-x C-e 直接下载包

;; Emacs 自带功能但是可以使用 use-package 进行配置
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Auto-Revert.html
;; 自动重载进行设置，让我们的Emacs在文件发生改变的时候自动重载文件。
;; 启用 autorevert 后，Emacs 会定期检查磁盘上的文件，看看它是否被修改过。如果文件已被修改，Emacs 将自动使用最新更改重新加载缓冲区。
(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode)
  :bind ("s-u" . revert-buffer)            ;; 设置快捷键 可以恢复缓存区
  :custom
  (auto-revert-interval 10)                ;;  Emacs 每 10 秒检查一次文件
  (auto-revert-avoid-polling t)            ;; 避免轮询文件更改
  (auto-revert-verbose nil)                ;; 不在还原缓冲区时打印消息
  (auto-revert-remote-files t)             ;; 还原远程文件
  (auto-revert-check-vc-info t)            ;; 检查版本控制信息
  (global-auto-revert-non-file-buffers t)) ;; 还原非文件缓冲区

;;----------------------------------------------------------
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
;;----------------------------------------------------------
;; 主题配置
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

;;----------------------------------------------------------
;; mode-line(状态栏)配置
;; 需要先加载主题才能加载状态栏
;; https://github.com/Malabarba/smart-mode-line
;;
(use-package smart-mode-line
    :init
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'respectful)
    (sml/setup))

;;----------------------------------------------------------
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

;;----------------------------------------------------------
;; keycast 显示emacs按键和执行函数
;; https://github.com/tarsius/keycast
(use-package keycast
  :init
  ;;(keycast-mode-line-mode )
  :config
  (setq keycast-mode-line-mode nil    ;; 初始化不打开 需要打开 M-x keycast-mode RET 
        ;;keycast-header-line-mode t  ;; 左上角显示
	keycast-tab-bar-mode t)       ;; 在 mode-line 上显示
  )

;;----------------------------------------------------------
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

;;----------------------------------------------------------
;; ivy-posframe 修改 mini-buffer
;; https://github.com/tumashu/ivy-posframe
;;
;; 前提是得安装 ivy
;;

;;----------------------------------------------------------
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
     :bind
     (("C-=" . cnfonts-increase-fontsize)
      ("C--" . cnfonts-decrease-fontsize))
  )


;;==========================================================
;; 文本编辑——强化搜索
;;==========================================================
;; 其实 emacs 中原生自带了 IDO 与 Icomplete 还有 FIDO (不用安装第三方软件)
;; IDO 是给出命令的建议或者候选
;;   https://www.emacswiki.org/emacs/InteractivelyDoThings
;;
;; Icomplete 可以简单的理解为 自动代码(补全)命令
;;   https://www.gnu.org/software/emacs/manual/html_node/emacs/Icomplete.html
;;   https://www.emacswiki.org/emacs/IcompleteMode
;;
;; FIDO 可以理解成 IDO 与 Icomplete 两者的结合
;; (fido-mode t) ;;启用fido
;;
;; ivy-counsel-swiper三剑客，同时优化了一系列 Minibuffer 的操作
;; https://github.com/abo-abo/swiper

;; ivy是一个通用的命令补全接口
;;  主要是为Counsel 和 Swiper 提供基础支持
;;   ivy 的补全是通过 Minibuffer 来显示的
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
	 ;;("C-r" .swiper+)
         ("C-S-f" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
                swiper-include-line-number-in-search t))

;; Counsel 主要是将emacs中的一些命令功能增强了，这些命令经过定制以充分利用 Ivy
;;   安装Counsel将同时安装Ivy和Swiper作为依赖
;;   其中 ivy 和 swiper 都是为增强 Counsel 服务的
;;   M-x counsel-rg 查询含某些字段的文档
(use-package counsel
  :after (ivy)
  :bind (("M-x" . counsel-M-x)           ;; 替换emacs原生的 M-x 键
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))

;;==========================================================
;;
;;----------------------------------------------------------
;; pdt-tools
;; https://github.com/vedang/pdf-tools/
(use-package pdf-tools
  :config
  ;;(pdf-tools-install) ;; 打开emacs就启动
  (pdf-loader-install)  ;; 打开pdf才启动
  (setq-default pdf-view-display-size 'fit-page)  ;; open pdfs scaled to fit page
  (setq pdf-annot-activate-created-annotations t)   ;; automatically annotate highlights 自动注释亮点
  ;;(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward) ;; use normal isearch
  (setq native-comp-deferred-compilation-deny-list '(".*pdf.*")) ;; 禁用pdf-tools本地化编译
  )

;;----------------------------------------------------------
;; AUCTex
;; https://www.gnu.org/software/auctex/
;;(use-package auctex)

;;==========================================================
;; Org-mode
;;----------------------------------------------------------
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
		 (org-mode . my/org-prettify-symbols))
  :commands (org-find-exact-headline-in-buffer org-set-tags)
  :config
  ;; 设置代码块用上下边线包裹 需要安装doom主题
  ;; (org-block-begin-line ((t (:underline t :background unspecified))))
  ;; (org-block-end-line ((t (:overline t :underline nil :background unspecified))))
  ;; 美化的一些符号
  (defun my/org-prettify-symbols () 
	(setq prettify-symbols-alist
		  (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
				  '(
					;; ("[ ]"              . 9744)         ; ☐
					;; ("[X]"              . 9745)         ; ☑
					;; ("[-]"              . 8863)         ; ⊟
					("#+begin_src"      . 9998)         ; ✎
					("#+end_src"        . 9633)         ; □
					("#+begin_example"  . 129083)       ; 🠻
					("#+end_example"    . 129081)       ; 🠹
					("#+results:"       . 9776)         ; ☰
					("#+attr_latex:"    . "🄛")
					("#+attr_html:"     . "🄗")
					("#+attr_org:"      . "🄞")
					("#+name:"          . "🄝")         ; 127261
					("#+caption:"       . "🄒")         ; 127250
					("#+date:"          . "📅")         ; 128197
					("#+author:"        . "💁")         ; 128100
					("#+setupfile:"     . 128221)       ; 📝
					("#+email:"         . 128231)       ; 📧
					("#+startup:"       . 10034)        ; ✲
					("#+options:"       . 9965)         ; ⛭
					("#+title:"         . 10162)        ; ➲
					("#+subtitle:"      . 11146)        ; ⮊
					("#+downloaded:"    . 8650)         ; ⇊
					("#+language:"      . 128441)       ; 🖹
					("#+begin_quote"    . 187)          ; »
					("#+end_quote"      . 171)          ; «
                    ("#+begin_results"  . 8943)         ; ⋯
                    ("#+end_results"    . 8943)         ; ⋯
					)))
   (setq prettify-symbols-unprettify-at-point t)
   (prettify-symbols-mode 1))
  :custom
  (org-startup-with-inline-images t) ;; 自动显示图片
  )
;; org-modern
(use-package org-modern
  :hook (after-init . (lambda ()
			(setq org-modern-hide-start 'leading)
			(global-org-modern-mode t)))
  :config
  
  (setq org-modern-star ["◉" "○" "✸" "✳" "◈" "◇" "✿" "❀" "✜"] ;; 标题行型号字符
        org-ellipsis "⤵" ;; 设置标题行折叠符号 ▼ ↴ ⬎ ⤷  ⋱
        org-pretty-entities t ;; 以UTF-8显示
        org-modern-block-fringe t ;; 代码块左边加上一条竖边线
        org-modern-block-name nil ;; 代码块类型美化，这里使用了 `prettify-symbols-mode'
        org-modern-keyword nil    ;; #+<关键字> 的美化，这里使用了 `prettify-symbols-mode'
        )
  ;; 复选框美化
  (setq org-modern-checkbox
        '((?X . #("▢✓" 0 2 (composition ((2)))))
          (?- . #("▢–" 0 2 (composition ((2)))))
          (?\s . #("▢" 0 1 (composition ((1)))))))
  ;; 列表符号美化
  (setq org-modern-list
        '((?- . "•")
          (?+ . "◦")
          (?* . "▹")))
  )

;;----------------------------------------------------------
;; org-appear
;; https://github.com/awth13/org-appear
;; 当我们的光标移动到Org mode里的强调、链接上时，会自动展开，这样方便进行编辑。
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t)      ;; 将链接自动转换为可见
  (setq org-appear-autosubmarkers t) ;; 将下标和上标标记自动转换为可见
  (setq org-appear-autoentities t)   ;; 将特殊字符自动转换为可见
  (setq org-appear-autokeywords t)   ;; 将关键字自动转换为可见
  (setq org-appear-inside-latex t)   ;; 将 LaTeX 元素自动转换
  )

;;----------------------------------------------------------
;; org-noter
;; https://github.com/weirdNox/org-noter
;;
(use-package org-noter
  :after org
  :config
  (setq org-noter-default-notes-file-names '("notes.org")   ;;默认注释文件名
	org-noter-notes-search-path '("~/Documents/notes") ;;Org note 还需要一个（或多个）搜索路径来搜索文档注释。
	org-noter-separate-notes-from-heading t)
  )
;;----------------------------------------------------------
;; org-fragtog
;; https://github.com/io12/org-fragtog
;; 光标离开公式输入的region之后自动调用 ```org-latex-preview``` 生成预览
(use-package org-fragtog
  :after org
  :hook
  (org-mode . org-fragtog-mode))

;;----------------------------------------------------------
;; ob-ipython
(use-package ob-ipython)

;;----------------------------------------------------------
;; 笔记
;;----------------------------------------------------------
;; org-roam
;; https://www.orgroam.com/
;; https://github.com/org-roam/org-roam
(use-package org-roam
  :custom
  (org-roam-directory "~/Note/") ;; 默认笔记目录(如果没有就会出现 Warring)
  ;;(org-roam-dailies-directory "daily/") ;; 默认日记位置(是上一个目录地址的相对路径)
  (org-roam-db-gc-threshold most-positive-fixnum) ;; 提高性能
  :bind (("C-c n l" . org-roam-buffer-toggle)   ;; 显示
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
	 ("C-c n u" . org-roam-ui-mode) ;;浏览器中可视化
         ;; Dailies
         ;;("C-c n j" . org-roam-dailies-capture-today)
	 )
  :config
  (org-roam-db-autosync-mode) ;; 启动时自动同步数据库
  ) 

;; org-roam-ui
;; https://github.com/org-roam/org-roam-ui
(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
	;;org-roam-ui-open-on-start t
        org-roam-ui-update-on-save t)
  ;;:config
  ;;(org-roam-ui-sync-theme t) ;; 同步 Emacs 主题
  ;;(org-roam-ui-follow-mode t) ;; 笔记节点追踪
  ;;(org-roam-ui-open-on-start t) ;; 打开emacs就启动
  ;;(org-roam-ui-update-on-save t) ;; 自动同步更新
  )


;;==========================================================
;; 补全/检查/智能
;;==========================================================
;; company 补全
;; http://company-mode.github.io/
;; https://github.com/company-mode/company-mode
;;
;;  简单来说 dabbrev 是 Emacs 的内置包，通过对当前缓冲区的文本进行搜索来完成匹配功能
;;  company 是通过添加许多包来完善 dabbrev 功能(eg:为语义信息、片段和其他类型的数据提供补全的能力)
;;  company 的后端就是 `company-dabbrev`
;;    它的工作原理是使用 dabbrev 包在当前缓冲区的文本中搜索匹配项
;;    可以配置补全候选的最小长度，是否忽略大小写，是否在注释和字符串中进行搜索
;;    company-dabbrev 后端默认仅在当前缓冲区中搜索完成候选，但是 "company-dabbrev-code-other-buffers" 可以设置其他缓冲区
;;  company-backends 是 company 提供完成候选的所有后端的列表。
;;    列表中后端的顺序很重要，因为列表中的第一个后端将首先使用，然后是第二个后端，依此类推。
;;    https://company-mode.github.io/manual/Backends.html
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
	;;company-lsp-enable-snippet t              
        company-tooltip-offset-display 'scrollbar ;; 如果候选词比较多，以滚动条的形式显示 | 另一个选项是 (setq company-tooltip-offset-display 'lines) 就是全部显示
        company-begin-commands '(self-insert-command org-self-insert-command ))	;;设置在org-mode 模式下自动补全
  (push '(company-semantic :with company-yasnippet) company-backends)  ;; 将 company-semantic 和 company-yasnippet 后端添加到 company-backends 列表的末尾
  :hook ((after-init . global-company-mode))      ;; 开机就启动
  ;;:custom
  ;;(lsp-headerline-breadcrumb-enable t)
  ;;(lsp-headerline-breadcrumb-enable-symbol-numbers t)
  :bind
  ;; ("C-TAB" . company-complete)
  ("C-c y y" . company-yasnippet)                   ;; 显示 yasnippet 的补全
  ;; (global-set-key (kbd "C-c y") 'company-yasnippet)
  )

;;----------------------------------------------------------
;; yasnippet
;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.d/lib/snippets"))
  ;;(add-to-list 'yas-snippet-dirs "~/.emacs.d/lib/snippets")
  ;;(with-eval-after-load 'yasnippet
  ;;  ;;(validate-setq yas-snippet-dirs '(yasnippet-snippets-dir))
  ;;  (validate-setq yas-snippet-dirs "~/.emacs.d/lib/snippets")
  ;;  )
  ;;(yas-global-mode t)
  ;;(setq yasnippet-snippets--fixed-indent nil)
  :hook
  ((prog-mode text-mode) . yas-minor-mode)
  :custom
  ;; 模板展开时，缩进保持不变
  (yas-indent-line 'fixed)
  :bind
  ("C-c y s" . yas-insert-snippet)     ;; 插入 snippet 片段
  ("C-c y v" . yas-visit-snippet-file) ;; 查看 snippet 内容
  )
;;



;;----------------------------------------------------------
;; which-key 按键提示，辅助记忆组合键
;; 当按下一个快捷键的时候， which-key 会提示接下来可能全部的快捷键
;; https://github.com/justbur/emacs-which-key
;;
;;开启/关闭 M-x which-key-mode
;; 
(use-package which-key
  :defer nil
  :config
  (which-key-mode)
  ;; 美化：
  (add-to-list 'which-key-replacement-alist '(("TAB" . nil) . ("↹" . nil)))
  (add-to-list 'which-key-replacement-alist '(("ESC" . nil) . ("␛" . nil)))
  (add-to-list 'which-key-replacement-alist '(("RET" . nil) . ("⏎" . nil)))
  (add-to-list 'which-key-replacement-alist '(("DEL" . nil) . ("⇤" . nil)))
  (add-to-list 'which-key-replacement-alist '(("SPC" . nil) . ("␣" . nil)))
  )


;;----------------------------------------------------------
;; flycheck 语法检查
;; https://github.com/flycheck/flycheck
;; https://www.flycheck.org/en/latest/
;;
;; 语法检查器
;;   可以用 `C-c ! s` 来选择语法检查器，如果没有的话可以安装
;;   $ pip install pylint # 安装python的语法检查器
;;   $ npm install eslint # 安装Java的语法检查器
;;
;; | 快捷键  | 功能                                |
;; |---------+-------------------------------------|
;; | C-c t f | f                                   |
;; | C-c ! v | 检查您的 Flycheck 设置是否已完成    |
;; | C-c ! V | 检查您的 Flycheck 版本信息          |
;; |         |                                     |
;; | C-c ! p | 跳转到上个报错的地方                |
;; | C-c ! n | 跳转到下个报错的地方                |
;; | C-c ! l | 列出当前缓冲区中所有的报错error信息 |
;; |         |                                     |
;; | C-c ! i | 打开浏览器官方文档                  |
;; |         |                                     |
;; | C-c ! s | 选择语法检查器                      |
;;
;;
(use-package flycheck
  :init (global-flycheck-mode)
  :hook
  (prog-mode . flycheck-mode)    ;; 只在编程语言下启用
  ;;(after-init . global-flycheck-mode)
  )

;;----------------------------------------------------------
;; lsp
;; https://emacs-lsp.github.io/lsp-mode/
;; https://github.com/emacs-lsp/lsp-mode
;; 查看快捷键：https://emacs-lsp.github.io/lsp-mode/page/keybindings/
;; 
;; 使用 M-x lsp-doctor 验证您的 lsp-mode 是否配置正确
;; 
(use-package lsp-mode
  :init
  ;; (add-to-list 'company-backends 'company-capf)
  ;; (setq lsp-prefer-flymake nil            ;; 因为已经安装 fly-check 所以不需要使用
	;; lsp-keep-workspace-alive nil      ;; Auto kill LSP server
	;; lsp-enable-indentation nil
	;; lsp-enable-on-type-formatting nil
	;; lsp-auto-guess-root nil
	;; lsp-enable-snippet t
        ;; )
  ;; (add-hook 'lsp-completion-mode-hook (lambda ()
  ;;                                      (when lsp-completion-mode
  ;;                                        (set (make-local-variable 'company-backends)
  ;;                                             (remq 'company-capf company-backends)))))
  (defun lsp-save-actions ()
    "LSP actions before save."
    (add-hook 'before-save-hook #'lsp-organize-imports t t)
	(add-hook 'before-save-hook #'lsp-format-buffer t t))

  ;;:config (  
	   ;;(with-eval-after-load 'lsp-mode ;;忽略项目中某些文件/文件夹 详见：https://emacs-lsp.github.io/lsp-mode/page/file-watchers/
             ;; (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.my-folder\\'")
             ;; or
             ;; (add-to-list 'lsp-file-watch-ignored-files "[/\\\\]\\.my-files\\'"))
	     ;;(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.git\\'")
	   ;;(setq lsp-log-io nil)  ;; 关闭日志记录，提高工作性能
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  ;; 为 lsp-command-keymap 设置一个前缀(很少有人设置成 "C-l" 或 "C-c l")
  :config
  (setq lsp-auto-guess-root t
	lsp-headerline-breadcrumb-enable nil
	lsp-prefer-flymake nil
	lsp-keymap-prefix "C-c l"
	lsp-log-io nil)
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)

  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;; (XXX-mode . lsp) 或者 (XXX-mode . lsp-deferred)
	 ;; lsp 与 lsp-deferred 区别就是 lsp 开启emacs就启动，lsp-deferred 是进入某个模式启动
	 ;; (prog-mode . lsp-deferred) ;; 全部编程语言
	 (c++-mode . lsp-deferred)
	 (c-mode . lsp-deferred)
	 (java-mode . lsp-deferred)
	 (org-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
	 ;;(go-mode . lsp-deferred)
	 ;;(js-mode . lsp-deferred)
	 ;;(html-mode . lsp-deferred)
	 
         ;; 如果已经安装 which-key 插件，可以将 lsp 整合到 which-key 中
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  )

 ;; 2mb 一些语言服务器响应在 800k - 3M 范围内，emacs 默认值太低 4k,增加 Emacs 从进程中读取的数据量
 (setq read-process-output-max (* 2048 2048)) ;; 这个不能写到 use-package 配置里面

;; company-lsp 针对 lsp 的company后端
;; https://github.com/tigersoldier/company-lsp
;; 项目已经作废

;; lsp-ui 提供 lsp-mode 的所有更高级别的 UI 模块，比如 flycheck 支持和代码块显示
;; https://emacs-lsp.github.io/lsp-ui/
;; https://github.com/emacs-lsp/lsp-ui
;; 除非将 `lsp-auto-configure` 设置成 nil ，否则启动lsp-mode 就会自启动 lsp-ui
;;
(use-package lsp-ui
  :after lsp-mode
  :init (setq lsp-ui-doc-enable t
	      lsp-ui-doc-use-webkit nil
	      lsp-ui-doc-delay 0             ;;显示文档的延迟
	      lsp-ui-doc-include-signature t
	      lsp-ui-doc-position 'at-point
	      lsp-eldoc-enable-hover nil
	      lsp-ui-sideline-enable t
	      lsp-ui-sideline-show-hover nil
	      lsp-ui-doc-show-with-cursor nil  ;; 当光标移到符号的位置显示文档
	      lsp-ui-doc-show-with-mouse t     ;; 当鼠标移到符号的位置显示文档
	      lsp-ui-sideline-show-diagnostics nil
	      lsp-ui-sideline-ignore-duplicate t)
;;  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;;  (add-hook 'lsp-ui-mode-hook 'lsp-modeline-code-actions-mode)
  :config (setq lsp-ui-flycheck-enable t)
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; lsp-treemacs 提供项目目录树
;; https://github.com/emacs-lsp/lsp-treemacs
(use-package lsp-treemacs
  :after lsp
  :commands lsp-treemacs-errors-list)


;;----------------------------------------------------------
;; 安装语言服务器
;;
;; C/C++
;; 采用 ccls
;; https://github.com/MaskRay/ccls
;; 参考：https://github.com/MaskRay/ccls/wiki/lsp-mode
;;
;;
(use-package ccls
  ;;:config ((setq lsp-prefer-flymake nil)          ;; ccls 默认使用 flymake，这里禁用
	;;   
	;;   )
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))
(setq ccls-executable "/usr/bin/ccls") ;; 设置 ccls 的执行位置



;;----------------------------------------------------------
;; dap-mode以及对应的调试器
;; https://github.com/emacs-lsp/dap-mode
;; https://emacs-lsp.github.io/dap-mode
;; https://emacs-lsp.github.io/dap-mode/page/configuration/
;;
;;; (use-package dap-mode
;;;     :init
;;;     (add-hook 'lsp-mode-hook 'dap-mode)
;;;     (add-hook 'dap-mode-hook 'dap-ui-mode)
;;;     (add-hook 'dap-mode-hook 'dap-tooltip-mode)
;;;     ;;   (add-hook 'python-mode-hook (lambda() (require 'dap-python)))
;;;     ;;   (add-hook 'go-mode-hook (lambda() (require 'dap-go)))
;;;     ;;   (add-hook 'java-mode-hook (lambda() (require 'dap-java)))
;;;     )





;;==========================================================
;;==========================================================
;;文档结束
(provide 'my_use_package)
