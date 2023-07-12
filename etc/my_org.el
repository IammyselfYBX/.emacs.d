;;==========================================================
;; Org-mode
;;==========================================================
;;----------------------------------------------------------
;; 整体设置
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
  (setq org-src-window-setup 'curren0t-window) ;; 编写代码块时分割当前窗口
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
;;(setq org-image-actual-width nil) ;; 使用图像的实际宽度

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


;;==========================================================
;;导出
;;==========================================================
;;----------------------------------------------------------
;配置org-export使用xelatex来做pdf的生成
(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process '("xelatex -interaction=nonstopmode %f")) ;; 执行xelatex 命令 -interaction=nonstopmode 告诉 TeX 引擎在不与用户交互的情况下运行，并尽可能“跳过”错误。
(add-to-list 'org-latex-default-packages-alist '("" "ctex" t ("xelatex")))

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
