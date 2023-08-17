;;==========================================================
;; Org-mode
;;==========================================================
;;----------------------------------------------------------
;; 引入判断操作系统的库
;;(add-to-list 'load-path "~/.emacs.d/lib/OS")
;;(require 'judge_os)
;; 整体设置
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
		 (org-mode . my/org-prettify-symbols)
         (org-mode . company-mode))   ;; 使用company
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

  ;;(setq org-src-window-setup 'current-window) ;; 编写代码块时分割当前窗口
  ;; 使用 M-x describe-variable org-src-window-setup 列出可以选的可能
  (setq org-src-window-setup 'split-window-below)
  :custom
  (org-startup-with-inline-images t) ;; 自动显示图片
  ;;:bind
  )

;;==========================================================
;; 美化 与 显示
;;==========================================================
;;----------------------------------------------------------
;; org-modern
(use-package org-modern
  :hook (after-init . (lambda ()
			(setq org-modern-hide-start 'leading)
			(global-org-modern-mode t)))
  :config
  (setq ;;org-modern-star ["◉" "○" "✸" "✳" "◈" "◇" "✿" "❀" "✜"] ;; 标题行型号字符
        org-modern-star ["☯️" "🌟" "⚛️" "⚝" "◈" "◇" "✿" "❀" "✜"] ;; 标题行型号字符
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
;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

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



;;默认只显示一级标题
(setq org-startup-folded t)



;;==========================================================
;; 笔记
;;==========================================================
;;----------------------------------------------------------
;; org-noter
;; https://github.com/weirdNox/org-noter
;; 结合pdf-tools 的笔记系统
(use-package org-noter
  :after org
  :config
  (setq org-noter-default-notes-file-names '("notes.org")   ;;默认注释文件名
	org-noter-notes-search-path '("~/Documents/notes") ;;Org note 还需要一个（或多个）搜索路径来搜索文档注释。
	org-noter-separate-notes-from-heading t
    org-noter-always-create-frame nil)
  )

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

;;----------------------------------------------------------
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

;; org-download
;; https://github.com/abo-abo/org-download
;; 将图像拖放到 Emacs 组织模式

;; 复制粘贴
;; 通过 xclip 实现
;; sudo pacman -S xclip # Linux
;; brew install pngpaste # Mac
(use-package emacs
  :ensure nil
  :after org   ;;默认在orgmode模式才开启
  :bind (:map org-mode-map
              ("s-V" . my/org-insert-clipboard-image)) ;; Super+Shift+v 实现粘贴图片
  :config
  (defun my/org-insert-clipboard-image (width)
    "create a time stamped unique-named file from the clipboard in the sub-directory
 (%filename.assets) as the org-buffer and insert a link to this file."
    (interactive (list
                  (read-string (format "Input image width, default is 800: ") 
                               nil nil "800"))) ;; 图片宽度默认是 800
    ;; 设置图片存放的文件夹位置为 `当前Org文件同名.assets'
    (setq foldername (concat (file-name-base (buffer-file-name)) ".assets/"))
    (if (not (file-exists-p foldername))
        (mkdir foldername))
    ;; 设置图片的文件名，格式为 `img_年月日_时分秒.png'
    (setq imgName (concat "img_" (format-time-string "%Y%m%d_%H%M%S") ".png"))
    ;; 图片文件的相对路径
    (setq relativeFilename (concat (file-name-base (buffer-name)) ".assets/" imgName))
    ;; 根据不同的操作系统设置不同的命令行工具
    (cond ((string-equal system-type "gnu/linux")
           (shell-command (concat "xclip -selection clipboard -t image/png -o > " relativeFilename)))
          ((string-equal system-type "darwin")
           (shell-command (concat "pngpaste " relativeFilename))))
    ;; 给粘贴好的图片链接加上宽度属性，方便导出
    (insert (concat "\n#+DOWNLOADED: screenshot @ "
                    (format-time-string "%Y-%m-%d %a %H:%M:%S" (current-time))
                    "\n#+CAPTION: \n#+ATTR_ORG: :width "
                    width
                    "\n#+ATTR_LATEX: :width "
                    (if (>= (/ (string-to-number width) 800.0) 1.0)
                        "1.0"
                      (number-to-string (/ (string-to-number width) 800.0)))
                    "\\linewidth :float nil\n"
                    "#+ATTR_HTML: :width "
                    width
                    "\n[[file:" relativeFilename "]]\n"))
    ;; 重新显示一下图片
    (org-redisplay-inline-images)
    )
  )


;;----------------------------------------------------------
;; 执行代码快
;; Babel 语言支持
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)
   (ipython . t)
   (C . t)
   (latex . t)
   (shell . t)
   (emacs-lisp . t)))
;; (emacs-lisp . nil) 不需要那个就这样写

;;----------------------------------------------------------
;; ob-ipython
(use-package ob-ipython)

;; 不再询问是否允许执行代码块
(setq org-confirm-babel-evaluate nil)

;; 显示和更新代码生成的图片
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; orgmode 调整图片尺寸
(setq org-image-actual-width nil) ;; 使用图像的实际宽度

;;==========================================================
;; Latex
;;==========================================================
;;----------------------------------------------------------
;; org-fragtog
;; https://github.com/io12/org-fragtog
;; 光标离开公式输入的region之后自动调用 ```org-latex-preview``` 生成预览
(use-package org-fragtog
  :after org
  :hook
  (org-mode . org-fragtog-mode)
  :custom
  (org-fragtog-preview-delay 1.0))

;; https://github.com/dandavison/xenops
;; 支持org的异步preview Latex

;;----------------------------------------------------------
;; Latex preview
;org-preview-latex 默认不开启
(setq org-startup-with-latex-preview nil)

;;(图形界面)调整公式大小
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
;;(setq org-latex-packages-alist
;;             '(("fontset=STXingkai,UTF8" "ctex" t)))
; org-mode preview无法显示中文的问题
; 需要在公式中出现中文的地方，都使用 \mbox{} 
;org-latex-prewiew 函数的大概处理流程为，先查询到当前buffer当前光标下 公式开始与结尾，再通过 org-preview-latex-default-process 变量获取到 需要使用的处理流程，再通过 org-preview-latex-process-alist 查到对应 处理过程需要使用到的命令，最后把公式的插入到一个固定模板，在按照定义好 的处理流程将 LaTeX 的代码转化为png或者svg显示在buffer当中。
(add-to-list 'org-preview-latex-process-alist '(xdvsvgm :progams
							("xelatex" "dvisvgm")     ;; 指定进程使用的程序, 这里是 xelatex 和 dvisvgm
							:discription "xdv > svg"  ;; 简短说明
							:message "you need install the programs: xelatex and dvisvgm." ;;指定在进程失败时显示的消息。
							:image-input-type "xdv"   ;; 这个字段的值不为dvi，而应该是xdv， xelatex 处理之后的文件后缀为xdv，再通过 dvisvgm 处理成svg。
							:image-output-type "svg"
							:image-size-adjust (1.7 . 1.5) ;; 缩放图像。在这种情况下，图像在水平方向上缩放 1.7，在垂直方向上缩放 1.5
							:latex-compiler 
							("xelatex -interaction nonstopmode -no-pdf -output-directory %o %f")
							:image-converter
							("dvisvgm %f -n -b min -c %S -o %O")
;;						(imagemagick :programs
;;                                                        ("xelatex" "convert")
;;                                                        :description "pdf > png"
;;							:message "you need to install the programs: xelatex and imagemagick."
;;							:use-xcolor t
;;							:image-input-type "pdf"
;;							:image-output-type "png"
;;							:image-size-adjust (1.0 . 1.0)
;;							:latex-compiler
;;							("xelatex -interaction nonstopmode -output-directory %o %f")
;;							:image-converter
;;							("convert -density %D -trim -antialias %f -quality 100 %O"))
							))
(setq org-preview-latex-default-process 'xdvsvgm)
;;(setq org-preview-latex-default-process 'imagemagick)


;; orgmode使用 cdlatex
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)


;;==========================================================
;;导出
;;==========================================================
;; 生成目录
;; toc-org
;; https://github.com/snosov1/toc-org
;; 使用方法
;;     ~C-c C-q~ 在地下的 Tags: 写 `toc`
;;     然后按 ~C-x C-s~ 保存的时候就会出现目录
(use-package toc-org 
  :hook (org-mode . toc-org-mode))

;;----------------------------------------------------------
;; 导出成 PDF —— ox-latex
;; ox-latex 是Org mode自带的功能，可以将Org文件导出为latex文件和PDF文件。
;;
(use-package ox-latex
  :ensure nil
  :defer t
  :config
  (add-to-list 'org-latex-default-packages-alist '("" "ctex" t ("xelatex"))) ;; 支持汉语
  (add-to-list 'org-latex-classes
               '("cn-article"
                 "\\documentclass[UTF8,a4paper]{article}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '("cn-report"
                 "\\documentclass[11pt,a4paper]{report}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (setq org-latex-default-class "cn-article")
  (setq org-latex-image-default-height "0.9\\textheight"
        org-latex-image-default-width "\\linewidth")
  (setq org-latex-compiler "xelatex") ;;使用xelatex来做pdf的生成
  (setq org-latex-pdf-process
	    '("xelatex -interaction nonstopmode -output-directory %o %f"
	      "bibtex %b"
	      "xelatex -interaction nonstopmode -output-directory %o %f"
	      "xelatex -interaction nonstopmode -output-directory %o %f"
	      "rm -fr %b.out %b.log %b.tex %b.brf %b.bbl auto"
	      ))
  ;; 使用 Listings 宏包格式化源代码(只是把代码框用 listing 环境框起来，还需要额外的设置)
  ;;(setq org-latex-listings t)
  ;; 设置org-mode的源代码block默认导出的latex的environment为minted
  ;;(setq org-latex-listings 'minted
  ;;    org-latex-packages-alist '(("" "minted"))
  ;;)
  ;; 设置org-mode的源代码block默认导出的latex的environment为listtings
  (setq org-latex-listings 'listings)
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  ;; mapping jupyter-python to Python
  (add-to-list 'org-latex-listings-langs '(jupyter-python "Python"))
  ;; Options for \lset command（reference to listing Manual)
  (setq org-latex-listings-options
        '(
          ("basicstyle" "\\small\\ttfamily")       ; 源代码字体样式
          ("keywordstyle" "\\color{eminence}\\small")                 ; 关键词字体样式
          ;; ("identifierstyle" "\\color{doc}\\small")
          ("commentstyle" "\\color{commentgreen}\\small\\itshape")    ; 批注样式
          ("stringstyle" "\\color{red}\\small")                       ; 字符串样式
          ("showstringspaces" "false")                                ; 字符串空格显示
          ("numbers" "left")                                          ; 行号显示
          ("numberstyle" "\\color{preprocess}")                       ; 行号样式
          ("stepnumber" "1")                                          ; 行号递增
          ("xleftmargin" "2em")                                       ;
          ;; ("backgroundcolor" "\\color{background}")                   ; 代码框背景色
          ("tabsize" "4")                                             ; TAB 等效空格数
          ("captionpos" "t")                                          ; 标题位置 top or buttom(t|b)
          ("breaklines" "true")                                       ; 自动断行
          ("breakatwhitespace" "true")                                ; 只在空格分行
          ("showspaces" "false")                                      ; 显示空格
          ("columns" "flexible")                                      ; 列样式
          ("frame" "tb")                                              ; 代码框：single, or tb 上下线
          ("frameleftmargin" "1.5em")                                 ; frame 向右偏移
          ;; ("frameround" "tttt")                                       ; 代码框： 圆角
          ;; ("framesep" "0pt")
          ;; ("framerule" "1pt")                                         ; 框的线宽
          ;; ("rulecolor" "\\color{background}")                         ; 框颜色
          ;; ("fillcolor" "\\color{white}")
          ;; ("rulesepcolor" "\\color{comdil}")
          ("framexleftmargin" "5mm")                                  ; let line numer inside frame
          ))
  )
;配置org-export使用xelatex来做pdf的生成
;;(setq org-latex-compiler "xelatex")
;;(setq org-latex-pdf-process '("xelatex -interaction=nonstopmode %f")) ;; 执行xelatex 命令 -interaction=nonstopmode 告诉 TeX 引擎在不与用户交互的情况下运行，并尽可能“跳过”错误。
;;(add-to-list 'org-latex-default-packages-alist '("" "ctex" t ("xelatex")))

;;----------------------------------------------------------
;; 导出成 Microsoft Office文件
;; 安装 ox-pandoc 插件
;; https://github.com/kawabata/ox-pandoc
(use-package ox-pandoc
  :custom
  ;; special extensions for markdown_github output
  (org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))
  (org-pandoc-command "/usr/bin/pandoc")
  )


;;==========================================================
;; 在缓冲区显示大纲
;; Imenu
;; 生成用于访问文档中位置的菜单，通常在当前缓冲区(有可以通过在 普通菜单 或 迷你缓冲区minibuffer )中显示
;;   https://www.gnu.org/software/emacs/manual/html_node/emacs/Imenu.html
;;   https://www.emacswiki.org/emacs/ImenuMode
;; 可以将 Imenu 与任何主要模式和任何编程语言或文档类型一起使用。
;; 如果您的上下文没有 Imenu 支持，您可以使用 EmacsLisp 和库 imenu.el 中提供的构造来添加它。
(add-to-list 'load-path "~/.emacs.d/lib/org/")
(require 'imenu-list)
(setq org-imenu-depth 10)
;; (imenu-list-minor-mode) ;;开启emacs 就启动
(global-set-key (kbd "C-i") 'imenu-list-smart-toggle)
;;(setq imenu-list-auto-resize t) ;;每次更新 *Ilist* 缓冲区时， *Ilist* 窗口的大小都可以自动调整
(setq imenu-list-position 'left)
(setq imenu-list-size 0.2)


;;==========================================================
;; Aganda设置
;;==========================================================
;; org-todo
;;  C-c C-t (org-todo) 来设置 TODO 状态，状态的种类由 org-todo-keywords 这个变量定义，默认值为 TODO 和 DONE
;(setq org-todo-keywords '((sequence "TODO(t)" "HOLD(h!)" "WIP(i!)" "WAIT(w!)" "|" "DONE(d!)" "CANCELLED(c@/!)")
;					      (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f!)")))


;;----------------------------------------------------------
;; 对 日历 Calendar 设置
(use-package calendar
  :ensure nil
  :hook (calendar-today-visible . calendar-mark-today)
  :custom
  ;; 是否显示中国节日，我们使用 `cal-chinese-x' 插件
  (calendar-chinese-all-holidays-flag nil)
  ;; 是否显示节日
  (calendar-mark-holidays-flag t)
  ;; 是否显示Emacs的日记，我们使用org的日记
  (calendar-mark-diary-entries-flag nil)
  ;; 数字方式显示时区，如 +0800，默认是字符方式如 CST
  (calendar-time-zone-style 'numeric)
  ;; 日期显示方式：year/month/day
  (calendar-date-style 'iso)
  ;; 中文天干地支设置
  (calendar-chinese-celestial-stem ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
  (calendar-chinese-terrestrial-branch ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])
  ;; 设置中文月份
  (calendar-month-name-array ["一月" "二月" "三月" "四月" "五月" "六月" "七月" "八月" "九月" "十月" "十一月" "十二月"])
  ;; 设置星期标题显示
  (calendar-day-name-array ["日" "一" "二" "三" "四" "五" "六"])
  ;; 周一作为一周第一天
  (calendar-week-start-day 1)
  )

;; 中国节日设置
(use-package cal-china-x
  :ensure t
  :commands cal-china-x-setup
  :hook (after-init . cal-china-x-setup)
  :config
  ;; 重要节日设置
  (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
  ;; 所有节日设置
  (setq cal-china-x-general-holidays
        '(;;公历节日
          (holiday-fixed 1 1 "元旦")
          (holiday-fixed 2 14 "情人节")
          (holiday-fixed 3 8 "妇女节")
          (holiday-fixed 3 14 "白色情人节")
          (holiday-fixed 4 1 "愚人节")
          (holiday-fixed 5 1 "劳动节")
          (holiday-fixed 5 4 "青年节")
          (holiday-float 5 0 2 "母亲节")
          (holiday-fixed 6 1 "儿童节")
          (holiday-float 6 0 3 "父亲节")
          (holiday-fixed 9 10 "教师节")
          (holiday-fixed 10 1 "国庆节")
          (holiday-fixed 10 2 "国庆节")
          (holiday-fixed 10 3 "国庆节")
          (holiday-fixed 10 24 "程序员节")
          (holiday-fixed 11 11 "双11购物节")
          (holiday-fixed 12 25 "圣诞节")
          ;; 农历节日
          (holiday-lunar 12 30 "春节" 0)
          (holiday-lunar 1 1 "春节" 0)
          (holiday-lunar 1 2 "春节" 0)
          (holiday-lunar 1 15 "元宵节" 0)
          (holiday-solar-term "清明" "清明节")
          (holiday-solar-term "小寒" "小寒")
          (holiday-solar-term "大寒" "大寒")
          (holiday-solar-term "立春" "立春")
          (holiday-solar-term "雨水" "雨水")
          (holiday-solar-term "惊蛰" "惊蛰")
          (holiday-solar-term "春分" "春分")
          (holiday-solar-term "谷雨" "谷雨")
          (holiday-solar-term "立夏" "立夏")
          (holiday-solar-term "小满" "小满")
          (holiday-solar-term "芒种" "芒种")
          (holiday-solar-term "夏至" "夏至")
          (holiday-solar-term "小暑" "小暑")
          (holiday-solar-term "大暑" "大暑")
          (holiday-solar-term "立秋" "立秋")
          (holiday-solar-term "处暑" "处暑")
          (holiday-solar-term "白露" "白露")
          (holiday-solar-term "秋分" "秋分")
          (holiday-solar-term "寒露" "寒露")
          (holiday-solar-term "霜降" "霜降")
          (holiday-solar-term "立冬" "立冬")
          (holiday-solar-term "小雪" "小雪")
          (holiday-solar-term "大雪" "大雪")
          (holiday-solar-term "冬至" "冬至")
          (holiday-lunar 5 5 "端午节" 0)
          (holiday-lunar 8 15 "中秋节" 0)
          (holiday-lunar 7 7 "七夕情人节" 0)
          (holiday-lunar 12 8 "腊八节" 0)
          (holiday-lunar 9 9 "重阳节" 0)))
  ;; 设置日历的节日，通用节日已经包含了所有节日
  (setq calendar-holidays (append cal-china-x-general-holidays)))

;;----------------------------------------------------------
;; org-capture
;; org-capture 的功能就是脑海中突然涌现了一个灵感，然后记录下来
(use-package org-capture
  :ensure nil
  :bind ("\e\e c" . (lambda () (interactive) (org-capture))) ;; ~ESC-ESC c~ 是唤起 org-capture 快捷键 
  :hook ((org-capture-mode . (lambda ()
                               (setq-local org-complete-tags-always-offer-all-agenda-tags t)))
         (org-capture-mode . delete-other-windows))
  :custom
  (org-capture-use-agenda-date nil)
  ;; 定义 capture 模板
  ;; https://orgmode.org/manual/Template-elements.html
  ;; 主要是 [t] Tasks
  ;;        [n] Notes
  ;;        [b] Bookmarks
  ;;        [d] Diary
  ;;        Diary 的二级目录
  ;;           [t] Today's TODO list
  ;;           [o] Other stuff
  (org-capture-templates `(("t" "Tasks" entry (file+headline "tasks.org" "Reminders")
                            ;; t 表示这个快速记录的快捷键设置
                            ;; Tasks 显示在快捷键右边的提示文本
                            ;; 设置这个快速记录保存到哪个文件的什么位置 这里是 tasks.org文件下的 Reminders 标题
                            "* TODO %i%?"         ;; 这个是初始模板                            
                            :empty-lines-after 1  ;; 这个是在这个快速记录后插入一个空行
                            :prepend t)           ;; 是插入到最前面的位置，默认是插入到最后一个位置   
                           ("n" "Notes" entry (file+headline "capture.org" "Notes")
                            "* %? %^g\n%i\n"
                            :empty-lines-after 1)
                           ;; For EWW
                           ("b" "Bookmarks" entry (file+headline "capture.org" "Bookmarks")
                            "* %:description\n\n%a%?"
                            :empty-lines 1
                            :immediate-finish t)
                           ("d" "Diary")
                           ("dt" "Today's TODO list" entry (file+olp+datetree "diary.org")
                            "* Today's TODO list [/]\n%T\n\n** TODO %?"
                            :empty-lines 1
                            :jump-to-captured t)
                           ("do" "Other stuff" entry (file+olp+datetree "diary.org")
                            "* %?\n%T\n\n%i"
                            :empty-lines 1
                            :jump-to-captured t)
                           ))
  )


(provide 'my_org)
