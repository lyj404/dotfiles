;; 关闭emacs临时文件
(setq auto-save-default nil)
;; 关闭备份文件
(setq make-backup-files nil)
;; 设置 tab 为两个空格宽度
(setq-default tab-width 4)
(setq tab-width 4)
;; 在关闭 Emacs 前询问是否确认关闭，防止误触
(setq confirm-kill-emacs #'yes-or-no-p)
;; 关闭自动调节行高
(setq auto-window-vscroll nil)
;; 设置文件编码
(setq default-buffer-file-coding-system 'utf-8)
;; 关闭Emacs的响铃
(setq ring-bell-function 'ignore)
;; 设置光标样式。
(setq-default cursor-type 'bar)
;; 光标和字符宽度一致（如 TAB)。
(setq x-stretch-cursor t)
;; 设置字体和大小
(set-face-attribute 'default nil :font "JetBrainsMono NF-12")
;; 设置字体缩放比例
(setq face-font-rescale-alist '(("JetBrainsMono NF" . 1.0)))
;; 关闭启动空白buffer
(setq initial-scratch-message "")
;; 关闭启动界面
(setq inhibit-startup-screen t)

;; 启用ido-mode，ido-mode 会增强 Emacs 的文件和缓冲区选择功能
(ido-mode 1)
;; 高亮当前行
(global-hl-line-mode 1)
;; 在 Window 显示行号
(global-display-line-numbers-mode t)
;; 选中文本时输入将会替换选中的文本
(delete-selection-mode t)
;; 在 Mode line 上显示列号
(column-number-mode t)
;; 文件更新时即时刷新 Buffer
(global-auto-revert-mode t)
;; 将yes和no简化成y和n
(fset 'yes-or-no-p 'y-or-n-p)

;; 禁用鼠标点击粘贴
(setq  mouse-yank-at-point t)
;; 禁用鼠标中键点击
(global-unset-key (kbd "<mouse-2>")) 
;; 禁用鼠标右键双击剪切
(fset 'mouse-save-then-kill 'ignore)

(provide 'init-basic)
