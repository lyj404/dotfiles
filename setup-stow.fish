#!/usr/bin/fish

# 进入 dotfiles 目录
cd (dirname (status --current-filename))

# 如果没有参数，默认处理所有包
set packages $argv
if test (count $argv) -eq 0
    set packages "bash" "nano" "fish" "lazygit" "emacs" "fcitx5-rime"
end

# 定义颜色
set success_color (set_color green)
set error_color (set_color red)
set info_color (set_color blue)
set reset_color (set_color normal)

# 开始执行
echo "🚀 Starting stow process..."

# 遍历并执行 stow
for pkg in $packages
    echo "$info_color📦 Stowing $pkg...$reset_color"
    if stow -v --target=$HOME $pkg
        echo "$success_color✅ Successfully stowed $pkg!$reset_color"
    else
        echo "$error_color❌ Failed to stow $pkg!$reset_color"
        exit 1
    end
end

# 完成
echo "$success_color🎉 All packages stowed successfully!$reset_color"
