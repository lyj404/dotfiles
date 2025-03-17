function fish_right_prompt
    # 保存原始退出状态码
    set -l last_status $status

    # 颜色和图标定义
    set -l success_color (set_color 00FF7F)  # 绿色
    set -l error_color (set_color ff5f5f)    # 红色
    set -l success_icon "󰔟"                   # 倒计时图标
    set -l error_icon "󰅚 "                     # 错误图标

    # *仅当命令失败时* 显示错误图标
    if test $last_status -ne 0
        echo -n -s $error_color$error_icon
        return
    end

    # *命令成功时* 处理所有时间显示逻辑
    # 处理 CMD_DURATION 未设置的情况（设为 0）
    set -l duration 0
    if set -q CMD_DURATION
        set duration $CMD_DURATION
    end

    # 时间格式化（即使 duration 为 0 也显示）
    set -l time_str
    if test $duration -lt 1000
        set time_str $duration"ms"
    else if test $duration -lt 60000
        set seconds (math -s1 "$duration / 1000")
        set seconds (string replace -r '\.0$' '' -- $seconds)
        set time_str $seconds"s"
    else
        set minutes (math "$duration / 60000")
        set seconds (math "($duration % 60000) / 1000")
        set time_str $minutes"m"$seconds"s"
    end

    # 显示成功图标和时间（包括 0ms）
    echo -n -s $success_color$success_icon" "$success_color$time_str
end
