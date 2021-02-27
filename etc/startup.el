;;设置系统编码
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;;设置垃圾回收阈值，加速启动速度。
(setq gc-cons-threshold most-positive-fixnum)

;;关闭备份
(setq make-backup-files nil auto-save-default nil)

;;关闭锁文件
(setq create-lockfiles nil)

;;总是加载最新的文件
(setq load-prefer-newer t)

;;关闭字体缓存
(setq inhibit-compacting-font-caches nil)

;;记录上一次关闭位置，打开自动跳转
(save-place-mode 1)


(provide 'startup)
