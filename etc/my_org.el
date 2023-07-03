;;==========================================================
;;org-mode
;;==========================================================
;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

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

;; 不再询问是否允许执行代码块
(setq org-confirm-babel-evaluate nil)

;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; orgmode 调整图片尺寸
(setq org-image-actual-width nil)

;;默认只显示一级标题
(setq org-startup-folded t)

;;图形界面 Latex preview 调整大小
;;(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.0))
; org-mode preview无法显示中文的问题
; 需要在公式中出现中文的地方，都使用 \mbox{} 
;org-latex-prewiew 函数的大概处理流程为，先查询到当前buffer当前光标下 公式开始与结尾，再通过 org-preview-latex-default-process 变量获取到 需要使用的处理流程，再通过 org-preview-latex-process-alist 查到对应 处理过程需要使用到的命令，最后把公式的插入到一个固定模板，在按照定义好 的处理流程将 LaTeX 的代码转化为png或者svg显示在buffer当中。
;;;; (add-to-list 'org-preview-latex-process-alist '(xdvsvgm :progams
;;;; 							("xelatex" "dvisvgm")
;;;; 							:discription "xdv > svg"
;;;; 							:message "you need install the programs: xelatex and dvisvgm."
;;;; 							:image-input-type "xdv"
;;;; 							:image-output-type "svg"
;;;; 							:image-size-adjust (1.7 . 1.5)
;;;; 							:latex-compiler ("xelatex -interaction nonstopmode -no-pdf -output-directory %o %f")
;;;; 							:image-converter ("dvisvgm %f -n -b min -c %S -o %O")))
;;;; (setq org-preview-latex-default-process 'xdvsvgm)


;org-preview-latex 默认不开启
;;;; (setq org-startup-with-latex-preview nil)

;;----------------------------------------------------------
;;导出
;配置org-export使用xelatex来做pdf的生成
;;;; (setq org-latex-compiler "xelatex")
;;;; (setq org-latex-pdf-process '("xelatex %f"))
;;;; (add-to-list 'org-latex-default-packages-alist '("" "ctex" t ("xelatex")))

;;----------------------------------------------------------
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



(provide 'my_org)
