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
    # 颜色定义
    set -l cyan (set_color 8be9fd)
    set -l magenta (set_color bd93f9)
    set -l green (set_color 50fa7b)
    set -l red (set_color ff005f)
    set -l normal (set_color normal)

    # 路径显示
    set -l full_cwd (pwd)
    if test "$full_cwd" = "$HOME"
        set cwd $cyan(whoami)
    else
        set cwd $cyan(string replace -r "^$HOME" '~' "$full_cwd")
    end

    # Git信息
    set -l git_info
    if set -l branch_name (_git_branch_name)
        set -l status_icons (_git_status_icons)
        set git_info $magenta" $branch_name $status_icons"
    end

    # 分步输出+颜色重置
    echo -n -s $cwd$normal
    if test -n "$git_info"
        echo -n -s " "$git_info$normal
    end
    echo -n -s " " $cyan"❯" $normal" "
end

