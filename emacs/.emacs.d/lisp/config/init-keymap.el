;; 全选快捷键
(global-set-key (kbd "s-a") 'mark-whole-buffer)
;; 保存快捷键
(global-set-key (kbd "C-c s") 'save-buffer)
;; 删除光标所在行
(global-set-key (kbd "C-S-k") 'kill-whole-line)
;; 复制当前行到下一行
(global-set-key (kbd "C-c n") 'copy-line-to-next-line)

(defun copy-line-to-next-line ()
  "Copy the current line to the next line, placing the cursor at the end of the new line."
  (interactive)
  (let ((current-line (thing-at-point 'line t)))
    (end-of-line)       ; 移动到行尾
    (newline)           ; 插入新行
    (insert current-line) ; 插入当前行的内容
    (end-of-line)))     ; 移动到新行的末尾


(provide 'init-keymap)
