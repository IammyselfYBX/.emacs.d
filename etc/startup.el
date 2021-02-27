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

(provide 'startup)
