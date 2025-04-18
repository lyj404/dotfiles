#!/usr/bin/fish

# 强制进入物理目录（处理符号链接情况）
cd (realpath ~/dotfiles) || exit 1

# 默认包列表
set packages $argv
if test (count $argv) -eq 0
    set packages bash nano fish lazygit emacs starship fcitx5-rime zed wechat-universal
end

# 定义颜色
set success_color (set_color green)
set error_color (set_color red)
set info_color (set_color blue)
set warn_color (set_color yellow)
set reset_color (set_color normal)

# 智能检测函数
function is_pkg_linked -a pkg
    # 预检包存在性
    if not test -d $pkg
        echo "$error_color❌ Package $pkg does not exist!$reset_color"
        return 2
    end

    # 遍历包内所有文件检查链接状态
    for file in (find $pkg -type f -o -type l)
        set target_path (string replace -r "^$pkg/" "" $file)
        set abs_target $HOME/$target_path

        # 检查符号链接状态
        if test -L $abs_target
            # 验证是否指向当前包
            set link_target (realpath $abs_target)
            set expected_target (realpath $file)
            if test "$link_target" != "$expected_target"
                echo "$warn_color⚠️ $target_path 被其他链接占用$reset_color"
                return 1
            end
        else if test -e $abs_target
            # 存在实体文件需要处理
            return 1
        end
    end
    return 0
end

# 智能参数生成器
function get_stow_args -a pkg
    is_pkg_linked $pkg
    switch $status
        case 0
            echo "-v"
        case 1
            echo "-v"
            echo "--adopt"
        case 2
            return 1
    end
end

# 主流程
echo "🚀 Starting stow process in "(realpath .)"..."

for pkg in $packages
    echo "$info_color📦 Processing $pkg...$reset_color"
    
    # 获取动态参数
    if not set stow_args (get_stow_args $pkg)
        echo "$error_color❌ 无法处理 $pkg!$reset_color"
        exit 1
    end

    # 执行差异化操作
    echo "$info_color⚙️ 使用参数: stow $stow_args $pkg$reset_color"
    if stow --dotfiles --override=all -t $HOME -d $PWD $stow_args $pkg
        echo "$success_color✅ Stowed $pkg successfully!$reset_color"
    else
        echo "$error_color❌ Critical error processing $pkg!$reset_color"
        exit 1
    end
end

echo "$success_color🎉 All done! System ready for use.$reset_color"
