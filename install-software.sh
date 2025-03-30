#!/bin/bash

# 启用严格错误检查
set -euo pipefail

# 显示简洁文字图标
function show_icon() {
  echo -e "\n\033[1;36m=== 系统配置脚本 ===\033[0m"
}

# 刷新字体缓存
function refresh_fonts() {
    echo -e "\n\033[1;33m刷新字体缓存...\033[0m"
    fc-cache -fv
}

# Shell切换功能
function ask_change_shell() {
    echo -e "\n\033[1;34m=== Shell切换选项 ===\033[0m"
    
    # 检测fish是否安装
    if ! command -v fish &> /dev/null; then
        echo -e "\033[1;31m错误：未找到fish，请确认安装是否成功\033[0m"
        return 1
    fi

    # 获取当前shell路径
    local current_shell
    current_shell=$(getent passwd "$USER" | cut -d: -f7)
    local fish_path
    fish_path=$(which fish)

    # 已设置则跳过
    if [[ "$current_shell" == "$fish_path" ]]; then
        echo -e "\033[1;32m✓ 当前默认shell已是fish\033[0m"
        return 0
    fi

    # 交互式选择
    while true; do
        read -rp "是否将默认shell切换为fish？(y/n，默认y) " yn
        case "${yn:-y}" in
            [Yy]* )
                echo -e "\n\033[1;33m正在切换默认shell...\033[0m"
                if chsh -s "$fish_path"; then
                    echo -e "\033[1;32m✓ 切换成功！\033[0m"
                    echo -e "注意：更改将在下次登录或启动新终端时生效"
                else
                    echo -e "\033[1;31m切换失败，请尝试手动执行："
                    echo -e "chsh -s $(which fish)\033[0m"
                fi
                break
                ;;
            [Nn]* )
                echo -e "保持当前默认shell：$current_shell"
                break
                ;;
            * )
                echo "请输入 y 或 n"
                ;;
        esac
    done
}

# 主安装流程
function main() {
    clear
    show_icon
    
    # 交互式确认选项
    local CONFIRM_OPTION=""
    while true; do
        read -rp "启用自动确认模式？(y/n，默认y) " yn
        case "${yn:-y}" in
            [Yy]* ) CONFIRM_OPTION="--noconfirm"; break;;
            [Nn]* ) CONFIRM_OPTION=""; break;;
            * ) echo "请输入 y 或 n";;
        esac
    done

    # 安装官方包
    echo -e "\n\033[1;32m安装官方仓库软件包...\033[0m"
    sudo pacman -S --needed $CONFIRM_OPTION fish stow nano emacs starship exa bat zed

    # 安装AUR包
    echo -e "\n\033[1;35m安装AUR软件包...\033[0m"
    yay -S --needed $CONFIRM_OPTION lazygit rime-ice-git nerd-fonts-jetbrains-mono

    refresh_fonts
    ask_change_shell  # 新增的shell切换功能
}

# 执行主函数并捕获错误
main || {
    echo -e "\n\033[1;31m安装失败！请检查错误信息\033[0m" >&2
    exit 1
}

# 完成提示
echo -e "\n\033[1;32m✔ 所有操作已完成！\033[0m"
echo -e "建议操作："
echo -e "1. 重新登录以应用所有更改"
echo -e "2. 验证字体安装：fc-list | grep 'JetBrainsMono'"
echo -e "3. 启动fish shell：fish"
