function _git_branch_name
    git symbolic-ref --short HEAD 2>/dev/null
end

function _git_status_icons
    set -l changes (git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    if test $changes -gt 0
        echo (set_color red)"[!]"
    else
        echo (set_color green)"[✔]"
    end
end

function fish_prompt
    # 颜色定义（路径使用黄色）
    set -l path_color (set_color FFEB3B)  # 路径颜色改为黄色
    set -l blue (set_color 00afff)
    set -l magenta (set_color af87ff)
    set -l green (set_color 87ff00)
    set -l red (set_color ff005f)
    set -l normal (set_color normal)

    # 状态箭头（始终使用淡绿色）
    set prompt_segment $path_color"❯"

    # 路径显示逻辑
    set -l full_cwd (pwd)
    if test "$full_cwd" = "$HOME"
        set cwd $path_color(whoami)  # 直接显示用户名
    else
        set cwd $path_color(string replace -r "^$HOME" '~' "$full_cwd")
    end

    # Git 信息
    set -l git_info
    if set -l branch_name (_git_branch_name)
        set -l status_icons (_git_status_icons)
        set git_info $magenta" $branch_name $status_icons"
    end

    # 组合提示符（避免命令替换）
    set -l prompt_line $cwd
    if test -n "$git_info"
        set prompt_line "$prompt_line $git_info"
    end

    # 最终输出（固定一个箭头前空格）
    echo -n -s $prompt_line $normal " $prompt_segment "
end
